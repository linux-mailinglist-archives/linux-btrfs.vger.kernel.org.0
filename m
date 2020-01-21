Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6309414359C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 03:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgAUCSy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 21:18:54 -0500
Received: from smtpauth.rollernet.us ([208.79.240.5]:49670 "EHLO
        smtpauth.rollernet.us" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAUCSx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 21:18:53 -0500
Received: from smtpauth.rollernet.us (localhost [127.0.0.1])
        by smtpauth.rollernet.us (Postfix) with ESMTP id BD5452800040
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2020 18:18:52 -0800 (PST)
Received: from irrational.integralblue.com (pool-96-237-186-35.bstnma.fios.verizon.net [96.237.186.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by smtpauth.rollernet.us (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2020 18:18:52 -0800 (PST)
Received: from www.integralblue.com (irrational [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by irrational.integralblue.com (Postfix) with ESMTPSA id 75B7D5540981;
        Mon, 20 Jan 2020 21:18:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=integralblue.com;
        s=irrational; t=1579573131;
        bh=jg3MEZSWMm/eFTh6kSjUXRgHSYv3Idl/P3r+joHbgyg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=DRzCY8aj1JAfqEVtFRI35difYFP9J/iEQZegUa2o2QvIGOtDQ/pJ2OJVH1YjDGiYe
         jtF02OEzj1pDwZ+eeNmVIL1/RENsp1VQoEYO/WLREpg0V69rDyLTp9vD0Vb1YYnOJZ
         x5X99MySz4CCcIi/WpFqyLIxQpvvGVBCRU6vm7iU=
MIME-Version: 1.0
Content-Type: multipart/signed;
 protocol="application/pgp-signature";
 boundary="=_f750b0f8f93d694e19729ec88264337e";
 micalg=pgp-sha1
Date:   Mon, 20 Jan 2020 21:18:50 -0500
From:   Craig Andrews <candrews@integralblue.com>
To:     Craig Andrews <candrews@integralblue.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Regression in Linux 5.5.0-rc[1-5]: btrfs send/receive out of
 memory
In-Reply-To: <20200113133741.GU3929@twin.jikos.cz>
References: <5ba0716449eb4f838699fc0b1fb5b024@integralblue.com>
 <20200113133741.GU3929@twin.jikos.cz>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <7e7e4f63a89b6bb8a270d4c4ec676835@integralblue.com>
X-Sender: candrews@integralblue.com
X-Rollernet-Abuse: Processed by Roller Network Mail Services. Contact abuse@rollernet.us to report violations. Abuse policy: http://www.rollernet.us/policy
X-Rollernet-Submit: Submit ID 3da3.5e265f8c.b464f.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)

--=_f750b0f8f93d694e19729ec88264337e
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

I finally was able to test with this kernel.

With the kernel compiled from the branch "for-5.5-rc4" I do not get the 
out of memory error. However, I do this error:
btrfs send -p /mnt/everything/.snapshots/root.20200119 
/mnt/everything/.snapshots/root.20200120 | mbuffer -v 1 | btrfs receive 
/mnt/backup/.snapshots/
ERROR: failed to clone extents to var/amavis/db/__db.001: Invalid 
argument

I rebooted then immediately ran the same command with the 5.4 kernel and 
it completed successfully.

So I guess it's nice that I didn't get an out of memory error...

Thanks,
~Craig

--=_f750b0f8f93d694e19729ec88264337e
Content-Type: application/pgp-signature;
 name=signature.asc
Content-Disposition: attachment;
 filename=signature.asc;
 size=195
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRXYh1D8NS5wgKWveFHeNF+DbGKQgUCXiZfiwAKCRBHeNF+DbGK
QhLTAJ0UJphq0Xg12uyDdaHE/bVDqfbStwCgzPBFa30TvTaXdxsnc0II/GX1IpY=
=cifH
-----END PGP SIGNATURE-----

--=_f750b0f8f93d694e19729ec88264337e--
