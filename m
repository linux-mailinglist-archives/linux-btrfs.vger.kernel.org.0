Return-Path: <linux-btrfs+bounces-5405-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C57A8D78DE
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 00:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31625B20F12
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jun 2024 22:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8186753E15;
	Sun,  2 Jun 2024 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fclaJw10"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146B13612D
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Jun 2024 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717367660; cv=none; b=C6yrGWRK3JW15NoyOkFL7kjO8RMjo1YeSnEX8DfhEefqz/KqnI69JOYosl+ru74HTWsvTD4EnLWxHtN0961Ov2O8vD7T61yfTdAu+Qtb0pkEBIhH40SXTADce4sQzpNEgprw9v1d2pIMLR4yNBNd9RqoftJ/noS2uiJuW9ey8SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717367660; c=relaxed/simple;
	bh=wAO9m/LTYDHj/VtrFJmeawATSg2M+C7BWm2b2gPlkxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EZVIsPhNQFo3pqchsXeWMekbTXkDbtPVARdmSyQBZAtEd/JavRC2b5kEabvk0TxU+BTp4vO6PYwdzvLdmtORVnE6gfc/tr2Ciz4HotiEVsQSO8PkOtAqjOInf0fY7sv3z2aqbL7KgzpvVtQ0uV0UKBEoTtYRQLVCg/oLRmABvVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fclaJw10; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so7573291fa.0
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Jun 2024 15:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717367653; x=1717972453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ea2c5dskcWuzq0l2oAU+Bf95dm/7G6Y23LixFhu5N3k=;
        b=fclaJw10jaw34Un1nUa8PyIdqb3Nph21abhWwkzPzeCzbhM2Zt2f/L6iUWpJJTorU9
         HPSjSqzfqRusrfW/RS+W35OyhFmlUFSvwsLdEtNI5JSePEaf14KSW5+1ElS+kf5WXY28
         p4/LXo0QQFHenpRNG/daCMItomTTDkBgDpY81Nc9hG+iNgiloW+G+iGcDBDoNg+lwKqA
         0Ms84ihrpieFci5CfkGrRgz9KbKzMAYwHyhBaim4DA/pTK/UCrjtAcvrWkSkSAt2V7Rh
         TpV7Q2ZyawqKFDSZkr98ub7vzsIm50iXcofM63TzPYd2wUL/1HdHaFxJHiIov9B+aXYC
         Ix/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717367653; x=1717972453;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ea2c5dskcWuzq0l2oAU+Bf95dm/7G6Y23LixFhu5N3k=;
        b=SF+B8q97VWuJqCVCqaK3H4mXfrbtsNEbrpzHlkVHn2EmDeXB8xBm7tGxVTKwRJiGpP
         QcZP7NxrlGVtqiozvMRbSZrzTo1IRZPwR7OmS4BIlX+w8W9gFORGBW8pV8rLXwR5AeuN
         MQJzgW0ZTYOfvpHm6BpNk7I5o8lee4b2ex7f1376cjpbiCl+lfY+yPI1M6mbSAxGPkr9
         ObfDAfkcFHp/mjqbEdN7K2eku5BVMQtAtOfRPu7idJ9GHBUJ1mjYcmWo2/hwvGeH80xS
         uAf0cez+gF5ng8xXiFAXiydnT8IeRxIpjVDiunHIDeKFlpSApiSRPJFOX3YCygWpYVxE
         VJDg==
X-Forwarded-Encrypted: i=1; AJvYcCWcrStX8e6PYgBaVu2cFEFNqIadT9Y0Alo7WWHikwCwFk72Pui8dEy75fe7NXGzUyXk4j9ZaSC/531FbP7iROPP4IT54Ha3XP7fig4=
X-Gm-Message-State: AOJu0YzvtSeOz1YGCJukVUblMNdoD7Wp30RvHAqkNpwM1qExrKU+SKPE
	W6QOSKM+anxk+FWEQBSaMsyV44T2BCY4fGUl/GsKI5o9qQWEAXqUOjmGuoBeuuQ=
X-Google-Smtp-Source: AGHT+IGzHVNUaiCRjf8yXDX2q4jGbCxv1B95sI24w/DVJOocUrJaSC0QarkZMYxggIayXfwcNhenRw==
X-Received: by 2002:a2e:9f05:0:b0:2ea:91c1:f3d5 with SMTP id 38308e7fff4ca-2ea9510e39cmr60163101fa.15.1717367653020;
        Sun, 02 Jun 2024 15:34:13 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702425df2a4sm4362030b3a.54.2024.06.02.15.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 15:34:12 -0700 (PDT)
Message-ID: <8eb17569-40c6-4dda-835e-7913fa660ea3@suse.com>
Date: Mon, 3 Jun 2024 08:04:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External Email] Re: file system failure after hard reboot
 support request
To: William Rotach <wrotach1@binghamton.edu>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <51b057bf-ce55-4649-a70d-a7b4c7b8981d@binghamton.edu>
 <66fafc1b-3339-4336-a715-eb744d93155c@gmx.com>
 <485c4cfe-2141-4d6b-b478-f132b282b8da@binghamton.edu>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <485c4cfe-2141-4d6b-b478-f132b282b8da@binghamton.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/3 00:23, William Rotach 写道:
> The output requested:
> 
> $ sudo mount -o ro,rescue=all fc39.raw.disk mount
> mount: /run/media/sigurd/2c0361a4-804a-4a39-a37f-c3d3357706b6/mount: 
> can't read superblock on /dev/loop0.
>         dmesg(1) may have more information after failed mount system call.
> 
> 
> dmesg output:
> [581712.483114] BTRFS: device label fedora devid 1 transid 420465 
> /dev/loop0 scanned by mount (357575)
> [581712.483951] BTRFS info (device loop0): first mount of filesystem 
> e40e2cfb-83f5-48ff-a481-bf9f0cc22543
> [581712.483969] BTRFS info (device loop0): using crc32c (crc32c-intel) 
> checksum algorithm
> [581712.483974] BTRFS info (device loop0): using free-space-tree
> [581712.485488] BTRFS error (device loop0): bad tree block start, mirror 
> 1 want 823396630528 have 0
> [581712.485529] BTRFS error (device loop0): bad tree block start, mirror 
> 2 want 823396630528 have 0

The worst case scenario, either some writes are lost or wrongly 
discarded, the tree block range is fully wiped.

And even if we can find an older version, I strongly wonder if this is 
the only wiped range.

Mind to share the hardware model for the drive?


> [581712.485540] BTRFS warning (device loop0): couldn't read tree root
> [581712.486055] BTRFS error (device loop0): open_ctree failed
> 
> 
> 
> $ sudo btrfs check --readonly fc39.raw.disk
> Opening filesystem to check...
> checksum verify failed on 823396630528 wanted 0x02000000 found 0xabe960d0
> checksum verify failed on 823396630528 wanted 0x00000000 found 0x8b095422
> checksum verify failed on 823396630528 wanted 0x02000000 found 0xabe960d0
> bad tree block 823396630528, bytenr mismatch, want=823396630528, have=0
> Couldn't read tree root
> ERROR: cannot open file system
> 
> 
> 
> Additional items that may help:
> 
> $ sudo btrfs-find-root fc39.raw.disk
> Couldn't read tree root
> Superblock thinks the generation is 420465
> Superblock thinks the level is 0
> Well block 822913368064(gen: 419921 level: 0) seems good, but 
> generation/level doesn't match, want gen: 420465 level: 0

Tree root is one of the frequently updated tree, and with so many 
generation differences, it's almost impossible to grab a recent enough 
tree root.

And your  btrfs-restore attempts also shows tons of full wiped tree blocks.

Did you use discard mount option? IIRC the async discard used to have 
some problems on certain drives, and only got fixed recently.
That may be the culprit if you go with discard mount option, but still 
not sure.

If you didn't go discard mount option, then it looks like something 
totally wrong in the lower storage stack.

Anyway you can still try using btrfs-restore with different values, but 
it's recommended to manually inspect each root tree, and find the 
subvolume of your interest to maximize your chance to salvage your data.

But overall the situation looks very bad, a lot of tree blocks are fully 
wiped or has garbage.

Thanks,
Qu

> Well block 822850994176(gen: 419920 level: 0) seems good, but 
> generation/level doesn't match, want gen: 420465 level: 0
> Well block 822769500160(gen: 419917 level: 0) seems good, but 
> generation/level doesn't match, want gen: 420465 level: 0
> Well block 822661070848(gen: 419903 level: 0) seems good, but 
> generation/level doesn't match, want gen: 420465 level: 0
> Well block 822652043264(gen: 419902 level: 0) seems good, but 
> generation/level doesn't match, want gen: 420465 level: 0
> Well block 822608560128(gen: 419901 level: 0) seems good, but 
> generation/level doesn't match, want gen: 420465 level: 0
> Well block 822536175616(gen: 419890 level: 0) seems good, but 
> generation/level doesn't match, want gen: 420465 level: 0
> Well block 822557655040(gen: 419889 level: 0) seems good, but 
> generation/level doesn't match, want gen: 420465 level: 0
> Well block 335032057856(gen: 419888 level: 0) seems good, but 
> generation/level doesn't match, want gen: 420465 level: 0
> Well block 334896906240(gen: 419873 level: 0) seems good, but 
> generation/level doesn't match, want gen: 420465 level: 0
> Well block 334756773888(gen: 419858 level: 0) seems good, but 
> generation/level doesn't match, want gen: 420465 level: 0
> Well block 334651310080(gen: 419853 level: 0) seems good, but 
> generation/level doesn't match, want gen: 420465 level: 0
> 
> ...
> 
> The above actually has about 202 lines, but when working with "restore 
> -t <block> " I get the following, as a snippet of the first three blocks 
> listed:
> 
> $ sudo btrfs restore -t 822913368064 fc39.raw.disk mount
> parent transid verify failed on 822913368064 wanted 420465 found 419921
> checksum verify failed on 822913368064 wanted 0x47180c50 found 0xad52f1e7
> checksum verify failed on 822913368064 wanted 0x47180c50 found 0xad52f1e7
> bad tree block 822913368064, bytenr mismatch, want=822913368064, have=0
> Couldn't read tree root
> Could not open root, trying backup super
> parent transid verify failed on 822913368064 wanted 420465 found 419921
> checksum verify failed on 822913368064 wanted 0x47180c50 found 0xad52f1e7
> checksum verify failed on 822913368064 wanted 0x47180c50 found 0xad52f1e7
> bad tree block 822913368064, bytenr mismatch, want=822913368064, have=0
> Couldn't read tree root
> Could not open root, trying backup super
> parent transid verify failed on 822913368064 wanted 420465 found 419921
> checksum verify failed on 822913368064 wanted 0x47180c50 found 0xad52f1e7
> checksum verify failed on 822913368064 wanted 0x47180c50 found 0xad52f1e7
> bad tree block 822913368064, bytenr mismatch, want=822913368064, have=0
> Couldn't read tree root
> Could not open root, trying backup super
> 
> 
> $ sudo btrfs restore -t 822850994176 fc39.raw.disk mount
> parent transid verify failed on 822850994176 wanted 420465 found 419920
> checksum verify failed on 822850994176 wanted 0xbb3002e0 found 0x5563cd49
> parent transid verify failed on 822850994176 wanted 420465 found 419920
> Ignoring transid failure
> checksum verify failed on 823389634560 wanted 0x00000000 found 0x635063e8
> checksum verify failed on 823389634560 wanted 0x474c5f45 found 0xe645e8e0
> checksum verify failed on 823389634560 wanted 0x474c5f45 found 0xe645e8e0
> bad tree block 823389634560, bytenr mismatch, want=823389634560, 
> have=6860725264739945543
> ERROR: search for next directory entry failed: -5
> ERROR: searching directory mount/root/root/.config failed: -5
> ERROR: searching directory mount/root/root/.config failed: -5
> ERROR: searching directory mount/root/root/.config failed: -5
> Skipping existing file mount/root/root/.ssh/known_hosts.old
> If you wish to overwrite use -o
> 
> 
> $ sudo btrfs restore -t 822769500160 fc39.raw.disk mount
> parent transid verify failed on 822769500160 wanted 420465 found 419917
> checksum verify failed on 822769500160 wanted 0x40a0ba19 found 0x14b83719
> parent transid verify failed on 822769500160 wanted 420465 found 419917
> Ignoring transid failure
> checksum verify failed on 823389634560 wanted 0x00000000 found 0x635063e8
> checksum verify failed on 823389634560 wanted 0x474c5f45 found 0xe645e8e0
> checksum verify failed on 823389634560 wanted 0x474c5f45 found 0xe645e8e0
> bad tree block 823389634560, bytenr mismatch, want=823389634560, 
> have=6860725264739945543
> ERROR: search for next directory entry failed: -5
> ERROR: searching directory mount/root/root/.config failed: -5
> ERROR: searching directory mount/root/root/.config failed: -5
> ERROR: searching directory mount/root/root/.config failed: -5
> Skipping existing file mount/root/root/.ssh/known_hosts.old
> If you wish to overwrite use -o
> 
> 
> ...
> 
> 
> $ sudo btrfs insp dump-s -fa fc39.raw.disk
> superblock: bytenr=65536, device=fc39.raw.disk
> ---------------------------------------------------------
> csum_type               0 (crc32c)
> csum_size               4
> csum                    0x93e4ac38 [match]
> bytenr                  65536
> flags                   0x1
>                          ( WRITTEN )
> magic                   _BHRfS_M [match]
> fsid                    e40e2cfb-83f5-48ff-a481-bf9f0cc22543
> metadata_uuid           00000000-0000-0000-0000-000000000000
> label                   fedora
> generation              420465
> root                    823396630528
> sys_array_size          129
> chunk_root_generation   409806
> root_level              0
> chunk_root              26820608
> chunk_root_level        1
> log_root                0
> log_root_transid (deprecated)   0
> log_root_level          0
> total_bytes             2046703960064
> bytes_used              1019622313984
> sectorsize              4096
> nodesize                16384
> leafsize (deprecated)   16384
> stripesize              4096
> root_dir                6
> num_devices             1
> compat_flags            0x0
> compat_ro_flags         0x3
>                          ( FREE_SPACE_TREE |
>                            FREE_SPACE_TREE_VALID )
> incompat_flags          0x371
>                          ( MIXED_BACKREF |
>                            COMPRESS_ZSTD |
>                            BIG_METADATA |
>                            EXTENDED_IREF |
>                            SKINNY_METADATA |
>                            NO_HOLES )
> cache_generation        0
> uuid_tree_generation    420465
> dev_item.uuid           9228a628-82fc-4d77-94f3-d73c2b1b0802
> dev_item.fsid           e40e2cfb-83f5-48ff-a481-bf9f0cc22543 [match]
> dev_item.type           0
> dev_item.total_bytes    2046703960064
> dev_item.bytes_used     1139265241088
> dev_item.io_align       4096
> dev_item.io_width       4096
> dev_item.sector_size    4096
> dev_item.devid          1
> dev_item.dev_group      0
> dev_item.seek_speed     0
> dev_item.bandwidth      0
> dev_item.generation     0
> sys_chunk_array[2048]:
>          item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
>                  length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
>                  io_align 65536 io_width 65536 sector_size 4096
>                  num_stripes 2 sub_stripes 1
>                          stripe 0 devid 1 offset 22020096
>                          dev_uuid 9228a628-82fc-4d77-94f3-d73c2b1b0802
>                          stripe 1 devid 1 offset 30408704
>                          dev_uuid 9228a628-82fc-4d77-94f3-d73c2b1b0802
> backup_roots[4]:
>          backup 0:
>                  backup_tree_root:       823396630528    gen: 420465 
> level: 0
>                  backup_chunk_root:      26820608        gen: 409806 
> level: 1
>                  backup_extent_root:     823395287040    gen: 420465 
> level: 2
>                  backup_fs_root:         30572544        gen: 9 level: 0
>                  backup_dev_root:        2084816683008   gen: 409806 
> level: 1
>                  csum_root:      823394942976    gen: 420465 level: 2
>                  backup_total_bytes:     2046703960064
>                  backup_bytes_used:      1019622313984
>                  backup_num_devices:     1
> 
>          backup 1:
>                  backup_tree_root:       823395123200    gen: 420462 
> level: 0
>                  backup_chunk_root:      26820608        gen: 409806 
> level: 1
>                  backup_extent_root:     823394074624    gen: 420462 
> level: 2
>                  backup_fs_root:         30572544        gen: 9 level: 0
>                  backup_dev_root:        2084816683008   gen: 409806 
> level: 1
>                  csum_root:      823392043008    gen: 420462 level: 2
>                  backup_total_bytes:     2046703960064
>                  backup_bytes_used:      1019622301696
>                  backup_num_devices:     1
> 
>          backup 2:
>                  backup_tree_root:       823395500032    gen: 420463 
> level: 0
>                  backup_chunk_root:      26820608        gen: 409806 
> level: 1
>                  backup_extent_root:     823393845248    gen: 420463 
> level: 2
>                  backup_fs_root:         30572544        gen: 9 level: 0
>                  backup_dev_root:        2084816683008   gen: 409806 
> level: 1
>                  csum_root:      823393271808    gen: 420463 level: 2
>                  backup_total_bytes:     2046703960064
>                  backup_bytes_used:      1019622301696
>                  backup_num_devices:     1
> 
>          backup 3:
>                  backup_tree_root:       823396057088    gen: 420464 
> level: 0
>                  backup_chunk_root:      26820608        gen: 409806 
> level: 1
>                  backup_extent_root:     823395057664    gen: 420464 
> level: 2
>                  backup_fs_root:         30572544        gen: 9 level: 0
>                  backup_dev_root:        2084816683008   gen: 409806 
> level: 1
>                  csum_root:      823394222080    gen: 420464 level: 2
>                  backup_total_bytes:     2046703960064
>                  backup_bytes_used:      1019622301696
>                  backup_num_devices:     1
> 
> 
> superblock: bytenr=67108864, device=fc39.raw.disk
> ---------------------------------------------------------
> csum_type               0 (crc32c)
> csum_size               4
> csum                    0x338584f6 [match]
> bytenr                  67108864
> flags                   0x1
>                          ( WRITTEN )
> magic                   _BHRfS_M [match]
> fsid                    e40e2cfb-83f5-48ff-a481-bf9f0cc22543
> metadata_uuid           00000000-0000-0000-0000-000000000000
> label                   fedora
> generation              420465
> root                    823396630528
> sys_array_size          129
> chunk_root_generation   409806
> root_level              0
> chunk_root              26820608
> chunk_root_level        1
> log_root                0
> log_root_transid (deprecated)   0
> log_root_level          0
> total_bytes             2046703960064
> bytes_used              1019622313984
> sectorsize              4096
> nodesize                16384
> leafsize (deprecated)   16384
> stripesize              4096
> root_dir                6
> num_devices             1
> compat_flags            0x0
> compat_ro_flags         0x3
>                          ( FREE_SPACE_TREE |
>                            FREE_SPACE_TREE_VALID )
> incompat_flags          0x371
>                          ( MIXED_BACKREF |
>                            COMPRESS_ZSTD |
>                            BIG_METADATA |
>                            EXTENDED_IREF |
>                            SKINNY_METADATA |
>                            NO_HOLES )
> cache_generation        0
> uuid_tree_generation    420465
> dev_item.uuid           9228a628-82fc-4d77-94f3-d73c2b1b0802
> dev_item.fsid           e40e2cfb-83f5-48ff-a481-bf9f0cc22543 [match]
> dev_item.type           0
> dev_item.total_bytes    2046703960064
> dev_item.bytes_used     1139265241088
> dev_item.io_align       4096
> dev_item.io_width       4096
> dev_item.sector_size    4096
> dev_item.devid          1
> dev_item.dev_group      0
> dev_item.seek_speed     0
> dev_item.bandwidth      0
> dev_item.generation     0
> sys_chunk_array[2048]:
>          item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
>                  length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
>                  io_align 65536 io_width 65536 sector_size 4096
>                  num_stripes 2 sub_stripes 1
>                          stripe 0 devid 1 offset 22020096
>                          dev_uuid 9228a628-82fc-4d77-94f3-d73c2b1b0802
>                          stripe 1 devid 1 offset 30408704
>                          dev_uuid 9228a628-82fc-4d77-94f3-d73c2b1b0802
> backup_roots[4]:
>          backup 0:
>                  backup_tree_root:       823396630528    gen: 420465 
> level: 0
>                  backup_chunk_root:      26820608        gen: 409806 
> level: 1
>                  backup_extent_root:     823395287040    gen: 420465 
> level: 2
>                  backup_fs_root:         30572544        gen: 9 level: 0
>                  backup_dev_root:        2084816683008   gen: 409806 
> level: 1
>                  csum_root:      823394942976    gen: 420465 level: 2
>                  backup_total_bytes:     2046703960064
>                  backup_bytes_used:      1019622313984
>                  backup_num_devices:     1
> 
>          backup 1:
>                  backup_tree_root:       823395123200    gen: 420462 
> level: 0
>                  backup_chunk_root:      26820608        gen: 409806 
> level: 1
>                  backup_extent_root:     823394074624    gen: 420462 
> level: 2
>                  backup_fs_root:         30572544        gen: 9 level: 0
>                  backup_dev_root:        2084816683008   gen: 409806 
> level: 1
>                  csum_root:      823392043008    gen: 420462 level: 2
>                  backup_total_bytes:     2046703960064
>                  backup_bytes_used:      1019622301696
>                  backup_num_devices:     1
> 
>          backup 2:
>                  backup_tree_root:       823395500032    gen: 420463 
> level: 0
>                  backup_chunk_root:      26820608        gen: 409806 
> level: 1
>                  backup_extent_root:     823393845248    gen: 420463 
> level: 2
>                  backup_fs_root:         30572544        gen: 9 level: 0
>                  backup_dev_root:        2084816683008   gen: 409806 
> level: 1
>                  csum_root:      823393271808    gen: 420463 level: 2
>                  backup_total_bytes:     2046703960064
>                  backup_bytes_used:      1019622301696
>                  backup_num_devices:     1
> 
>          backup 3:
>                  backup_tree_root:       823396057088    gen: 420464 
> level: 0
>                  backup_chunk_root:      26820608        gen: 409806 
> level: 1
>                  backup_extent_root:     823395057664    gen: 420464 
> level: 2
>                  backup_fs_root:         30572544        gen: 9 level: 0
>                  backup_dev_root:        2084816683008   gen: 409806 
> level: 1
>                  csum_root:      823394222080    gen: 420464 level: 2
>                  backup_total_bytes:     2046703960064
>                  backup_bytes_used:      1019622301696
>                  backup_num_devices:     1
> 
> 
> superblock: bytenr=274877906944, device=fc39.raw.disk
> ---------------------------------------------------------
> csum_type               0 (crc32c)
> csum_size               4
> csum                    0xce02d2c7 [match]
> bytenr                  274877906944
> flags                   0x1
>                          ( WRITTEN )
> magic                   _BHRfS_M [match]
> fsid                    e40e2cfb-83f5-48ff-a481-bf9f0cc22543
> metadata_uuid           00000000-0000-0000-0000-000000000000
> label                   fedora
> generation              420465
> root                    823396630528
> sys_array_size          129
> chunk_root_generation   409806
> root_level              0
> chunk_root              26820608
> chunk_root_level        1
> log_root                0
> log_root_transid (deprecated)   0
> log_root_level          0
> total_bytes             2046703960064
> bytes_used              1019622313984
> sectorsize              4096
> nodesize                16384
> leafsize (deprecated)   16384
> stripesize              4096
> root_dir                6
> num_devices             1
> compat_flags            0x0
> compat_ro_flags         0x3
>                          ( FREE_SPACE_TREE |
>                            FREE_SPACE_TREE_VALID )
> incompat_flags          0x371
>                          ( MIXED_BACKREF |
>                            COMPRESS_ZSTD |
>                            BIG_METADATA |
>                            EXTENDED_IREF |
>                            SKINNY_METADATA |
>                            NO_HOLES )
> cache_generation        0
> uuid_tree_generation    420465
> dev_item.uuid           9228a628-82fc-4d77-94f3-d73c2b1b0802
> dev_item.fsid           e40e2cfb-83f5-48ff-a481-bf9f0cc22543 [match]
> dev_item.type           0
> dev_item.total_bytes    2046703960064
> dev_item.bytes_used     1139265241088
> dev_item.io_align       4096
> dev_item.io_width       4096
> dev_item.sector_size    4096
> dev_item.devid          1
> dev_item.dev_group      0
> dev_item.seek_speed     0
> dev_item.bandwidth      0
> dev_item.generation     0
> sys_chunk_array[2048]:
>          item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
>                  length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
>                  io_align 65536 io_width 65536 sector_size 4096
>                  num_stripes 2 sub_stripes 1
>                          stripe 0 devid 1 offset 22020096
>                          dev_uuid 9228a628-82fc-4d77-94f3-d73c2b1b0802
>                          stripe 1 devid 1 offset 30408704
>                          dev_uuid 9228a628-82fc-4d77-94f3-d73c2b1b0802
> backup_roots[4]:
>          backup 0:
>                  backup_tree_root:       823396630528    gen: 420465 
> level: 0
>                  backup_chunk_root:      26820608        gen: 409806 
> level: 1
>                  backup_extent_root:     823395287040    gen: 420465 
> level: 2
>                  backup_fs_root:         30572544        gen: 9 level: 0
>                  backup_dev_root:        2084816683008   gen: 409806 
> level: 1
>                  csum_root:      823394942976    gen: 420465 level: 2
>                  backup_total_bytes:     2046703960064
>                  backup_bytes_used:      1019622313984
>                  backup_num_devices:     1
> 
>          backup 1:
>                  backup_tree_root:       823395123200    gen: 420462 
> level: 0
>                  backup_chunk_root:      26820608        gen: 409806 
> level: 1
>                  backup_extent_root:     823394074624    gen: 420462 
> level: 2
>                  backup_fs_root:         30572544        gen: 9 level: 0
>                  backup_dev_root:        2084816683008   gen: 409806 
> level: 1
>                  csum_root:      823392043008    gen: 420462 level: 2
>                  backup_total_bytes:     2046703960064
>                  backup_bytes_used:      1019622301696
>                  backup_num_devices:     1
> 
>          backup 2:
>                  backup_tree_root:       823395500032    gen: 420463 
> level: 0
>                  backup_chunk_root:      26820608        gen: 409806 
> level: 1
>                  backup_extent_root:     823393845248    gen: 420463 
> level: 2
>                  backup_fs_root:         30572544        gen: 9 level: 0
>                  backup_dev_root:        2084816683008   gen: 409806 
> level: 1
>                  csum_root:      823393271808    gen: 420463 level: 2
>                  backup_total_bytes:     2046703960064
>                  backup_bytes_used:      1019622301696
>                  backup_num_devices:     1
> 
>          backup 3:
>                  backup_tree_root:       823396057088    gen: 420464 
> level: 0
>                  backup_chunk_root:      26820608        gen: 409806 
> level: 1
>                  backup_extent_root:     823395057664    gen: 420464 
> level: 2
>                  backup_fs_root:         30572544        gen: 9 level: 0
>                  backup_dev_root:        2084816683008   gen: 409806 
> level: 1
>                  csum_root:      823394222080    gen: 420464 level: 2
>                  backup_total_bytes:     2046703960064
>                  backup_bytes_used:      1019622301696
>                  backup_num_devices:     1
> 
> 
> 
> On 6/1/24 11:29 PM, Qu Wenruo wrote:
>  >
>  >
>  > 在 2024/6/2 11:30, William Rotach 写道:
>  >>
>  >>    I have reached out to a couple different locations for help with
>  >> BTRFS, and I have reached a dead end at my google-foo, and my
>  >> distributions discussion boards.  If there is a better place to ask for
>  >> help with respect to a hard file system crash, please let me know.
>  >>    I have a corrupted BTRFS file system, with a quick summary in bullet
>  >> points:
>  >> -    single new NVME, 6 months old, 2Tb size, 1Tb used, 200Mb of really
>  >> needed stuff
>  >> -    one backup exists, 6 months old, still need the new copies of 
> above
>  >> needed files
>  >> -    Fedora 39
>  >> -    chromium, high tab count, apparent culprit
>  >> -    hard system lock (no ssh response, no console switching)
>  >> -    repeated hard system restarts, last one crashed btrfs file system
>  >> -    btrfs hard failures:
>  >> -        parent transid;
>  >> -        checksum;
>  >> -        bytenr;
>  >> -        search for next directory;
>  >> -        can't read tree root;
>  >> -        bad tree block start;
>  >> -        212 found roots, none seem to have a "good match", as noted 
> above
>  >
>  > Full "btrfs check --readonly" output please, not some truncated output.
>  >
>  > Meanwhile you can try "-o rescue=all,ro mount" option to see if it can
>  > mount, and the dmesg for such attempt.
>  >
>  > But according to the "can't read tree root" line, rescue mount may 
> not help.
>  >
>  > Thanks,
>  > Qu
>  >>
>  >>    I started looking into the kernel driver source code to help my
>  >> understanding of the physical layout, and may build a more forensic
>  >> method of retrieving the binary/text data that I need.  I hope there is
>  >> something that is already included in the btrfs-progs packaging,
>  >> available through the source code, or by the developer team itself.
>  >>
> 
> 

