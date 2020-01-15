Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECAE313CC69
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 19:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgAOSoS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 13:44:18 -0500
Received: from smtpauth.rollernet.us ([208.79.240.5]:33227 "EHLO
        smtpauth.rollernet.us" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbgAOSoR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 13:44:17 -0500
Received: from smtpauth.rollernet.us (localhost [127.0.0.1])
        by smtpauth.rollernet.us (Postfix) with ESMTP id 903572800079
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 10:44:16 -0800 (PST)
Received: from irrational.integralblue.com (pool-96-237-186-35.bstnma.fios.verizon.net [96.237.186.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by smtpauth.rollernet.us (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 10:44:16 -0800 (PST)
Received: from www.integralblue.com (irrational [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by irrational.integralblue.com (Postfix) with ESMTPSA id C5BD854FED44;
        Wed, 15 Jan 2020 13:44:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=integralblue.com;
        s=irrational; t=1579113854;
        bh=yoZpJn5RUxvHZ/u39yvJXufjhlSVjXbaskAoAaotQGw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=AgqXCgClIl/hFqrDctAM0zO8x1qrxa+XStbLNUl11rdh5R7L1aG2TxullS645PNUL
         l1K6J1YWeDomIObkHznK1DH4Z/aM++WnjScYSc3Y7C3A8j/rf/elfPLdyv0HPzc0Km
         d3uUpXWXnZ1XoeILNxAf2/3tkfHi0o8nAAia7u8E=
MIME-Version: 1.0
Content-Type: multipart/signed;
 protocol="application/pgp-signature";
 boundary="=_528a29f2473814e9c045e32255b61b36";
 micalg=pgp-sha1
Date:   Wed, 15 Jan 2020 13:44:14 -0500
From:   Craig Andrews <candrews@integralblue.com>
To:     Craig Andrews <candrews@integralblue.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Regression in Linux 5.5.0-rc[1-5]: btrfs send/receive out of
 memory
In-Reply-To: <2c240d7b2fbf62a661a237a2862dc2ab@integralblue.com>
References: <5ba0716449eb4f838699fc0b1fb5b024@integralblue.com>
 <20200113133741.GU3929@twin.jikos.cz>
 <2c240d7b2fbf62a661a237a2862dc2ab@integralblue.com>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <44b7cc2a580ee7555d28c6df59049d18@integralblue.com>
X-Sender: candrews@integralblue.com
X-Rollernet-Abuse: Processed by Roller Network Mail Services. Contact abuse@rollernet.us to report violations. Abuse policy: http://www.rollernet.us/policy
X-Rollernet-Submit: Submit ID b6d.5e1f5d80.820be.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)

--=_528a29f2473814e9c045e32255b61b36
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed

On 2020-01-13 09:48, Craig Andrews wrote:
> On 2020-01-13 08:37, David Sterba wrote:
>> On Mon, Jan 13, 2020 at 07:41:13AM -0500, Craig Andrews wrote:
>>> If I perform a btrfs send receive like so:
>>> 
>>> sh -c btrfs send -p /mnt/everything/.snapshots/root.20191230
>>> /mnt/everything/.snapshots/root.20191231 | btrfs receive
>>> /mnt/backup/.snapshots/
>>> 
>>> On Linux 5.4.0, the process completes successfully.
>>> 
>>> Starting with Linux 5.5.0-rc1 up to the current 5.5 rc, 5.5.0-rc5, 
>>> the
>>> result is the OOM killer being invoked which (among other process
>>> carnage) kills the btrfs processes stopping the backup.
>> 
>> As this is on the -rc1, it's possible that changes done in the MM
>> subsystem could change the logic of OOM and that send now is able to
>> trigger the OOM.
>> 
>> There are 2 btrfs patches in send.c but they reduce amount of work,
>> namely for heavily reflinked extents so the effects should be 
>> opposite.
>> 
>> To find out where's the cause, is it possible that you build a kernel
>> from the 5.4-based branch and run the send again? It's the same set of
>> btrfs patches that gets merged to 5.5.
>> 
>> From repository: 
>> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
>> branch: for-5.5-rc4
>> 
>> If this can't be done we'll find another way to debug it.
> 
> I've grabbed, compiled, and installed the kernel. I'll be able to tell
> you the results of running the test tomorrow at about this time.
> 

I couldn't get the kernel to boot so I need to spend more time on that.

Is there any info I can get that would be helpful using my current 
kernels (either 5.4 or 5.5.0-rc5) while I work out why I can't boot the 
kernel you linked me to?

Thanks,
~Craig

--=_528a29f2473814e9c045e32255b61b36
Content-Type: application/pgp-signature;
 name=signature.asc
Content-Disposition: attachment;
 filename=signature.asc;
 size=195
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRXYh1D8NS5wgKWveFHeNF+DbGKQgUCXh9dfgAKCRBHeNF+DbGK
QuGxAKDOdZYenQt6UPZL1Dd/tSYP23qDmQCggLQH5/vRyaVwj3atLhAmhjek9CY=
=dVjJ
-----END PGP SIGNATURE-----

--=_528a29f2473814e9c045e32255b61b36--
