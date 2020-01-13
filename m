Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 127AD1393F2
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 15:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgAMOtY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 09:49:24 -0500
Received: from smtpauth.rollernet.us ([208.79.240.5]:46986 "EHLO
        smtpauth.rollernet.us" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgAMOtX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 09:49:23 -0500
Received: from smtpauth.rollernet.us (localhost [127.0.0.1])
        by smtpauth.rollernet.us (Postfix) with ESMTP id A7123280085E
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2020 06:48:38 -0800 (PST)
Received: from irrational.integralblue.com (pool-96-237-186-35.bstnma.fios.verizon.net [96.237.186.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by smtpauth.rollernet.us (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2020 06:48:38 -0800 (PST)
Received: from www.integralblue.com (irrational [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by irrational.integralblue.com (Postfix) with ESMTPSA id 82AB854CA2BB;
        Mon, 13 Jan 2020 09:48:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=integralblue.com;
        s=irrational; t=1578926917;
        bh=XdivAJgNS7oCTn7L+PJtVDIpv9V2fjDCZi7OJP5JHaw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=bo9aANKdMkLmlY1BIwhfigyfEkPR14YlqiJqBIaqrGs898LiiccNAnHdQUujvfcHh
         EUDe1IfSAovgNWiCH3w5CoxOJyas+MEspYqaWSXO/UoVVi0al06cPaKjT3s6VJXUI0
         SeMrbnSweVLJLYsAQ1lz+RxyZKQXaAuVTq4eFp2M=
MIME-Version: 1.0
Content-Type: multipart/signed;
 protocol="application/pgp-signature";
 boundary="=_cf8bcc0db84dbb4175ed0530e24deb03";
 micalg=pgp-sha1
Date:   Mon, 13 Jan 2020 09:48:37 -0500
From:   Craig Andrews <candrews@integralblue.com>
To:     Craig Andrews <candrews@integralblue.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Regression in Linux 5.5.0-rc[1-5]: btrfs send/receive out of
 memory
In-Reply-To: <20200113133741.GU3929@twin.jikos.cz>
References: <5ba0716449eb4f838699fc0b1fb5b024@integralblue.com>
 <20200113133741.GU3929@twin.jikos.cz>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <2c240d7b2fbf62a661a237a2862dc2ab@integralblue.com>
X-Sender: candrews@integralblue.com
X-Rollernet-Abuse: Processed by Roller Network Mail Services. Contact abuse@rollernet.us to report violations. Abuse policy: http://www.rollernet.us/policy
X-Rollernet-Submit: Submit ID 47fe.5e1c8346.91b1e.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)

--=_cf8bcc0db84dbb4175ed0530e24deb03
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed

On 2020-01-13 08:37, David Sterba wrote:
> On Mon, Jan 13, 2020 at 07:41:13AM -0500, Craig Andrews wrote:
>> If I perform a btrfs send receive like so:
>> 
>> sh -c btrfs send -p /mnt/everything/.snapshots/root.20191230
>> /mnt/everything/.snapshots/root.20191231 | btrfs receive
>> /mnt/backup/.snapshots/
>> 
>> On Linux 5.4.0, the process completes successfully.
>> 
>> Starting with Linux 5.5.0-rc1 up to the current 5.5 rc, 5.5.0-rc5, the
>> result is the OOM killer being invoked which (among other process
>> carnage) kills the btrfs processes stopping the backup.
> 
> As this is on the -rc1, it's possible that changes done in the MM
> subsystem could change the logic of OOM and that send now is able to
> trigger the OOM.
> 
> There are 2 btrfs patches in send.c but they reduce amount of work,
> namely for heavily reflinked extents so the effects should be opposite.
> 
> To find out where's the cause, is it possible that you build a kernel
> from the 5.4-based branch and run the send again? It's the same set of
> btrfs patches that gets merged to 5.5.
> 
> From repository: 
> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
> branch: for-5.5-rc4
> 
> If this can't be done we'll find another way to debug it.

I've grabbed, compiled, and installed the kernel. I'll be able to tell 
you the results of running the test tomorrow at about this time.

Thank you for help,
~Craig

--=_cf8bcc0db84dbb4175ed0530e24deb03
Content-Type: application/pgp-signature;
 name=signature.asc
Content-Disposition: attachment;
 filename=signature.asc;
 size=195
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRXYh1D8NS5wgKWveFHeNF+DbGKQgUCXhyDRQAKCRBHeNF+DbGK
QisyAKClLBA8Rj+TZ4gB4sHvyknxq6Qt1wCgt+2L0AV1/Rjja2xIG+iW69vAdMk=
=VbDt
-----END PGP SIGNATURE-----

--=_cf8bcc0db84dbb4175ed0530e24deb03--
