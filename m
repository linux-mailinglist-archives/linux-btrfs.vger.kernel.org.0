Return-Path: <linux-btrfs+bounces-20073-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B62C5CED9C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 02 Jan 2026 03:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E4703008E82
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jan 2026 02:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD3630BF66;
	Fri,  2 Jan 2026 02:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+al3Kd/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5C415A86D
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Jan 2026 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767321448; cv=none; b=nEMSO9vHgJAbYdviYF7NJXc0wG7KeSr9QJTV6QRFMJldjTX96bM28JJEXZ6BCvi4jRB++763UfpUqyTe8Y4SgX4Jp5hVchAAoEfVKXTl2sbaEPBDi74jrzoo13D+n/aHyBuFlGcpDKeRUf+geFlWyMvMcMdIvwyJOVadEikv78k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767321448; c=relaxed/simple;
	bh=O7H3SavqtEesTlqLmrc3vJRVVZkg0FUz5gGIjqJePew=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CnyLBo9UXcVs+jH5upZhXKcTlCyLo/RmCnBw9BRcBQdPEcn0A+Db6E/p58WSMQRPONH2IUqf597po1a0KjHB/cdHFYDwazKroee1H1XU0huqM2G7doDaqoUpWmGTbA1nwE1Lx35drIadduDgvh6otbZHQedhK+lPbxE4a8Sy2Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+al3Kd/; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8ba0d6c68a8so1345067485a.1
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Jan 2026 18:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767321446; x=1767926246; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8lyPF4sanjEI0GPVmb1RqXzxFWuzhLAqrNZ81ivc2g=;
        b=P+al3Kd/5CboJVLEMMFqj4MGpBoiJ33j/JfZbNzqURRz8mR4WTyJRNWMtq9H4d3IGl
         T+r3+NmkeEcc3h0js/plt+du+bw4d/8aJTKjNKd2IqaZthg9iheXKSvHPNkD9xJjbn0y
         3+LH37KgzWDhyNlEupo+qku6fpFNy8JDjG7fOfmdPVg+F1rt/rpBMDa3mW9wgkcATG+3
         8CXEaxXvDUmf4wOsuWSAIK1dBkvsuwcXsHCWB8nbvESdXfP3G/Byf/xCuyG5RaWKLg5O
         I+O3F1OSSedCdTG0uJEMoVnVMFdOupiY7pQNZ8WSGQCB8oSfdw4gk1THokmN7nPLDmZ0
         isbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767321446; x=1767926246;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8lyPF4sanjEI0GPVmb1RqXzxFWuzhLAqrNZ81ivc2g=;
        b=rmUns17z9fOrJB5Y+dLQ+lh3ur7dvVoatx7JAWwLcNM/w3SrfLfxh63YlajfnZ+tKW
         4gI8mP/G8YDfGSG1yyvT0UAgPiii8tiDjvyEmMhnaa4FbI/DVPwdarNPW/C6dUlulYg8
         3Z5e1WTMsdFkWniANATgVCj0aaV18zaDilRvTIQkTghsiaN3hnIs5ereF+JShtSKrdFO
         tZVDMYXCW4/IQ+XtA/R25z0v6KGkIMgs1d6N9BPeSQX+uB0MgasGgmwgxpRwMhT7y3+j
         K7QvbJqf6sFYEtjgor8gFQofRWVeEI/72uRfFe16CUxINeNdDSSzEcrmm88Gx0TzvYcq
         17lg==
X-Forwarded-Encrypted: i=1; AJvYcCVH+hsPA5rugfa53vdulma1WRhx/txoTGJ5ShABL1oPxFOGYqtbjzSEOSjS7+Pu8OxA5aeZQtGxxjrmMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPuPGywFaQCwGHMf47jOQ9YQhsWsh9ZRmXmIYKQ4+UflZsXIEE
	n5FlNuJKeccMl4OwsUopW/SJU8rABDyhWDUQWK9RFBSP2+2DsUyFjRja+5t+3A==
X-Gm-Gg: AY/fxX7+My+KZ1oLZC0YZLzhwPIQ0KxEsPAF/WKqSE1++wIz0sCSWBFout19khyuXr3
	g2eYrVvDYXlUv8EVoqQKuhYNrZWfvyKvMy4eDVFeMRezXgbhgomFE3DeiCpBXYCAsj7ifcH1UWJ
	rxn8PpMhfyU2BULLSlxN7TcU9sM+iC1epYlGHrjN8Pp4GWEqEagwJtDYbXyy8N7/VXYRZW4iB1x
	0PBerPeFCnlIQkUOSCs/rpC4iMFz2LrwOeUkqWliqM7AuJgmsl+EMxmfm3gtXOYc4n+A8dIXSfE
	3QpCIWkpEtf4dop0IQvKM84spLf3TucwtZ5zjgmJfD98hoOEw+4DeP9ow0Vm3R3CQwM4t203G44
	ap8ntX2QtOxhCzFOE9Jnf8U3ngMFFEhwAsiJQ4TReRoeymKDq3pOfRpxJcuGtN4FaT/lu24whTh
	ZsuDOvHwRGACWfULWMNYAkzGbZpDU2wKK1MEeOxQNxkra7fP9DNOckmHv7pDojdMNTYAar
X-Google-Smtp-Source: AGHT+IGMQP5MbSyhmkaK2P4US+g94Pz+uUnnVnpVZ1JRM+dXtGUJd6Tztg3dXHHigr1bNPfUU7qQtA==
X-Received: by 2002:a05:620a:701a:b0:8b2:f2c5:e7f6 with SMTP id af79cd13be357-8c08f68140cmr6519724385a.37.1767321445996;
        Thu, 01 Jan 2026 18:37:25 -0800 (PST)
Received: from digitalmercury.freeddns.org (69-171-146-205.rdns.distributel.net. [69.171.146.205])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0968927c0sm3146245885a.21.2026.01.01.18.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 18:37:25 -0800 (PST)
From: Nicholas D Steeves <nsteeves@gmail.com>
To: Ulli Horlacher <framstag@rus.uni-stuttgart.de>, linux-btrfs@vger.kernel.org
Subject: Re: backup best practise?
In-Reply-To: <20260101234624.GA1955478@tik.uni-stuttgart.de>
References: <20260101234624.GA1955478@tik.uni-stuttgart.de>
Date: Thu, 01 Jan 2026 21:37:23 -0500
Message-ID: <87ikdkn3j0.fsf@digitalmercury.freeddns.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Happy New Year Ulli!

Ulli Horlacher <framstag@rus.uni-stuttgart.de> writes:

> What is the best practise for backup of a local btrfs file system?

This problem was solved pre-btrfs and it's called the "3-2-1 backup
rule".  Yes, it also applies to btrfs; however, there is some debate
about whether a snapshot counts as a "copy" when it shares extents.  My
view is that it doesn't count, because "accidental partial deletion" is
only one class of disaster.

> In my case, I have 2 disks: disk one contains a /home btrfs filesystem,
> disk two contins a /backup btrfs filesystem.
> So far I use:
> rsync -a --delete /home /backup
>
> The drawback of this methode is: In /home there are also *big* VMs which
> will be copied every time even if they have changed only a few bytes,
> because rsync works file based.
>
> Using RAID1 is not a backup. When I inadvertently delete a file it has
> gone on the mirror side, too.
>
> I have snapshots of /home, but they will not help me if disk one has a
> hardware failure.

Agreed!  It sounds like you want fast and space-efficient backups.
There's an out of date project called "backup-bench" that compares them:

  https://github.com/deajan/backup-bench

I chose borgbackup, and it is the only backup system that I've been
happy enough with to use for more than a decade.  Here is how I apply
the 3-2-1 target to my system (adapted to use your paths).  In every
case I assume a snapshot of /home is the source.

  1. Cron-automated daily backup of /home to /backup/borg-repo (where I
     return 12 days of daily snapshots).  This has saved me from a
     PSU+SSD failure once, and an SSD failure another time.
  2. Weekly backup of /home to /mnt/external-usb-on-ext4/borg-repo, that
     is a separate target.  I have 12 years of backups here, and I
     travel with this drive.  This one is unfortunately a
     prompt+clicking a button or pluging in an external disk and letting
     a udev rule initiate the backup.
  3. I use Syncthing to maintain a live mirror of my user files
     off-site, with a data-retention policy that sacrifices a bit of
     space for a margin of error in case of accidental deletion combined
     with physical disaster affecting the primary copy.  This mesh keeps
     my laptop, desktop, and an offsite server in sync.

I'm anxious about using the cloud in the impending post-quantum era so I
don't yet have quantum-computing-safe encrypted offsite cloud backup.

If you don't know about 3-2-1, here are two references:

  https://www.backblaze.com/blog/the-3-2-1-backup-strategy/
  https://www.reddit.com/r/DataHoarder/comments/1agd73m/the_321_rule_seems_to_have_multiple/

and a possible argument against 3-2-1:

  https://www.reddit.com/r/DataHoarder/comments/11bls7l/the_321_backup_recommendation_is_flawed/

I hope this is enough to upgrade your backup strategy!  I use custom
scripts for #1 and #2, but I've started working the borgmatic maintainer
about evolving borgmatic's btrfs support to the point where I can
recommend it wholeheartedly, and you can count on me to advocate for
btrfs-related borgmatic issues.

Best,
Nicholas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmlXL2MTHG5zdGVldmVz
QGdtYWlsLmNvbQAKCRBaiDBHX30QYSM/D/9yn+AXZpGnLthwC0mapTmIsybaQU0D
046FJEbx21pzzn2D/PZNHQnPtO8PKqV4uCcWvz6cGS/yxmOkZlXvaMX9TMJgA9fH
4E/j8Eccuqc928DpN/gZqBHlFoNqSAFUEAaNHvmXV7vmkLxRE66NW6lbczr7d3q/
JB/YQeicoq12/cEoBayQKRA5eFAs/7PyIx+ooLT+DDPyhKODvuxA+mxwZOOmgWPo
YoXbSRJKGCwWdavUGqU5w3p8SxvS+wtT8c687AfE0z6T7OzFNI0YftUUWU2q92bW
ClTbPtL4NPsKomA/Te1ZLwexjNg1huwF3qmfRZQL1Cab6qmqCtq0S/DE69yHamCm
eBjr3mmDTFCakE2H33slaJPydfBnjNtL11AHz7pgN0CYOWh4yMEy6sq1PuhIdbmE
8OsqH41jgkUHCiPND19G8Gge3g7DulnTsBv8H5LjSr1o2fZMpi6oeRBIsEeEt4mz
zBRq2j5BCi3i7Q+WcrG0sr3brO+Awxg07/H/nZNTIiPuDodqAei20hCxq4He8+TC
iyR1yAT4OSsQp+AsGPuqGDjjXmdJXaXfadryBgoNHdx7QPetJwTTBJ+QU0VyYfLT
5GeJTsjA0rx10q4Zh00hyCk+IlCq55qXthLckj4g2LeEumG4BApPttX4bOPUogGe
UM+jwC8i6Skp9Q==
=KuKX
-----END PGP SIGNATURE-----
--=-=-=--

