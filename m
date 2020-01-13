Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08565139150
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 13:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgAMMrb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 07:47:31 -0500
Received: from smtpauth.rollernet.us ([208.79.240.5]:38060 "EHLO
        smtpauth.rollernet.us" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgAMMrU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 07:47:20 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jan 2020 07:47:20 EST
Received: from smtpauth.rollernet.us (localhost [127.0.0.1])
        by smtpauth.rollernet.us (Postfix) with ESMTP id E2699280085E
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2020 04:41:15 -0800 (PST)
Received: from irrational.integralblue.com (pool-96-237-186-35.bstnma.fios.verizon.net [96.237.186.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by smtpauth.rollernet.us (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2020 04:41:15 -0800 (PST)
Received: from www.integralblue.com (irrational [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by irrational.integralblue.com (Postfix) with ESMTPSA id BFD4B54AD744
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2020 07:41:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=integralblue.com;
        s=irrational; t=1578919273;
        bh=Qg7urJWn0ao4xNDc4spIsWreuv6zGXxekQTtXdAZHhE=;
        h=Date:From:To:Subject;
        b=FYsOIkrcMrfpabFiqnz2/Ds2rRF3etlcL1afaLXCosjz+Xfe29BH9vSDysZoDDGfW
         wQNiOvk5fqU5ju/4tYVUENBeKsNkL9eKOpOMKAX1LPvOxOHoJAT2a6cnyUIlrefV4I
         kA7W8NfhqXjwLHGHFAfE9zjT9yVLQx/TFrJE6vVo=
MIME-Version: 1.0
Content-Type: multipart/signed;
 protocol="application/pgp-signature";
 boundary="=_dbf2970594203d6811412e262dfc8fb9";
 micalg=pgp-sha1
Date:   Mon, 13 Jan 2020 07:41:13 -0500
From:   Craig Andrews <candrews@integralblue.com>
To:     linux-btrfs@vger.kernel.org
Subject: Regression in Linux 5.5.0-rc[1-5]: btrfs send/receive out of memory
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <5ba0716449eb4f838699fc0b1fb5b024@integralblue.com>
X-Sender: candrews@integralblue.com
X-Rollernet-Abuse: Processed by Roller Network Mail Services. Contact abuse@rollernet.us to report violations. Abuse policy: http://www.rollernet.us/policy
X-Rollernet-Submit: Submit ID 339f.5e1c656b.dca78.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)

--=_dbf2970594203d6811412e262dfc8fb9
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed

If I perform a btrfs send receive like so:

sh -c btrfs send -p /mnt/everything/.snapshots/root.20191230 
/mnt/everything/.snapshots/root.20191231 | btrfs receive 
/mnt/backup/.snapshots/

On Linux 5.4.0, the process completes successfully.

Starting with Linux 5.5.0-rc1 up to the current 5.5 rc, 5.5.0-rc5, the 
result is the OOM killer being invoked which (among other process 
carnage) kills the btrfs processes stopping the backup.

I'm using the same kernel config, same hardware, etc in the two tests. 
The system has 16 GB of RAM, CPU is an i5-6500, arch is amd64.
/mnt/everything is a btrfs fs on luks (/dev/mapper/sda4) on a 1 TB SATA 
SSD (/dev/sda4). /mnt/backup is btfs fs on luks (/dev/mapper/backup) on 
a 2 TB external spinning rust HDD (/dev/sdb).

# df -H /mnt/everything/ /mnt/backup
Filesystem          Size  Used Avail Use% Mounted on
/dev/mapper/sda4    949G  698G  247G  74% /mnt/everything
/dev/mapper/backup  2.1T  1.1T  948G  53% /mnt/backup

I've attached logs and my kernel config to 
https://bugzilla.kernel.org/show_bug.cgi?id=206031

Thank you,
~Craig

--=_dbf2970594203d6811412e262dfc8fb9
Content-Type: application/pgp-signature;
 name=signature.asc
Content-Disposition: attachment;
 filename=signature.asc;
 size=195
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRXYh1D8NS5wgKWveFHeNF+DbGKQgUCXhxlaQAKCRBHeNF+DbGK
Ql+OAJ4ms1q3AOXNAN2Mgg7yFMbhQKpa6wCeNNssosD8X2oF06ou2S/hcTiy02w=
=PKz/
-----END PGP SIGNATURE-----

--=_dbf2970594203d6811412e262dfc8fb9--
