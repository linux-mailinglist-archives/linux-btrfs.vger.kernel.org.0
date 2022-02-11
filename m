Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A6C4B1D8E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 06:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiBKFCn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 00:02:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiBKFCm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 00:02:42 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1132025D7
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 21:02:39 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id o17so11027595ljp.1
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 21:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=SuNmac5jeQUMj0rI1bGZE/V/PN4swjresxOlAkLSgcM=;
        b=ZnKHDc66HkeZ5raoQph/fG34oyANMvH9E2knI2D61FjIQiG4M+e9S3m1Nhug80Jm+X
         wtWIUHAGfJnbKw3aFVl81qJO/MMIUOyzekJIWHI1++yjuoOE8QVuD2UbMyuw1Xjf31aQ
         LXValSmSrMSbemYNU7v3wuIKSnrJBIBruuUlU4aHwtqhLiqKE8pG2d5abPazRAALN6fY
         NXpu6DoA0VmqqKyBdH1bW8wMpvoyMuDtkmg+jhdIxM9Z4+2SYOp0x//9ocNrNcGDIGJU
         pNQ+Hv3XN9lbHOk9thsdvTRrPlJv/m0NQypJi5xtbGC+e7Z71fcgibXrJsg6xbKdxwYA
         iShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SuNmac5jeQUMj0rI1bGZE/V/PN4swjresxOlAkLSgcM=;
        b=37/KD9m0Ta+NOsFj7s07OzolV3ezMCDjC1ROBD84VTYEqz0hYn98eBJUKF76+5+5dt
         6Lj7uRQyXiAmAxjTkvbMIqzyQorQFnzGVdF8kSmaDRV5BdF7CWj/oiWaSgon6NJBK79B
         FVC99wDYRjUiKu3/6I23qR2SwsVX4oWgZhlL5pKErY9gM2ON7Z2+VTuTXr17IwaD/Buh
         9S/FfzdOrv6yQUlk7m6axiryiKKknFgzItYssOCBvv257prFoCaOUajFTiJay9oNVhTD
         KF31mfB7LCfhVJhtGQvnhUSCPlosFjHqOnlQADacyAHCCrm5t4p68qpzdwoSAnMxagJ9
         IbTg==
X-Gm-Message-State: AOAM533FKZ99Rl6zSZOQkWkVbFBL+tM2uHGD1cxq4WcXuCLPKk/3rtsf
        eq4cnwocMTB+wGaaKnlkDwp5dcVu+FG7hw==
X-Google-Smtp-Source: ABdhPJw8lbUyuiGRPjrsL+NnYa7n9PWpCuI3ibdEhPSZXAYqjzou3eTPj0YZPu9p97M6W6K8Q0Lq6A==
X-Received: by 2002:a05:651c:1721:: with SMTP id be33mr6974762ljb.221.1644555756887;
        Thu, 10 Feb 2022 21:02:36 -0800 (PST)
Received: from ?IPV6:2a00:1370:812d:59de:2181:1f23:e38:739a? ([2a00:1370:812d:59de:2181:1f23:e38:739a])
        by smtp.gmail.com with ESMTPSA id h3sm1469461lfu.258.2022.02.10.21.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 21:02:36 -0800 (PST)
Message-ID: <c75599fa-3b4e-5a5a-c695-75c99b315a06@gmail.com>
Date:   Fri, 11 Feb 2022 08:02:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Used space twice as actually consumed
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <9f936d59-d782-1f48-bbb7-dd1c8dae2615@gmail.com>
 <ecd46a18-1655-ec22-957b-de659af01bee@gmx.com>
 <65e916e1-61b4-0770-f570-8fd73c27fe03@gmail.com>
 <3a654f5d-e210-5c3e-4bcf-f0eae626cde2@gmx.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <3a654f5d-e210-5c3e-4bcf-f0eae626cde2@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11.02.2022 07:48, Qu Wenruo wrote:
...
>>>>
>>>> This apparently was once snapshot of root subvolume (52afd41d-c722-4e48-b020-5b95a2d6fd84).
>>>> There are more of them.
>>>>
>>>> Any chance those "invisible" trees continue to consume space? How can I remove them?
>>>
>>> They are being dropped in the background.
>>> You can wait for them to be completely dropped by using command "btrfs
>>> subvolume sync".
>>>
>>
>>
>> It returns immediately without waiting for anything
>>
>> bor@tw:~> sudo btrfs subvolume sync /
>>
>> bor@tw:~>
>>
>>
>> Also
>>
>> bor@tw:~/python-btrfs> sudo ./bin/btrfs-orphan-cleaner-progress /
>>
>> 0 orphans left to clean
>>
>>
>>
>> btrfs check does not show any issues.
> 
> There used to be a bug that some root doesn't get properly cleaned up.
> 
> To be sure, please provide the following dump:
> 
> # btrfs ins dump-tree -t root <device>
> 
> Thanks,
> Qu


btrfs-progs v5.16 

root tree

node 5555683328 level 1 items 3 free space 490 generation 120361 owner ROOT_TREE

node 5555683328 flags 0x1(WRITTEN) backref revision 1

fs uuid cc072e56-f671-4388-a4a0-2ffee7c98fdb

chunk uuid 4c1e6100-2dd5-47a0-9aa8-58510884045f

	key (EXTENT_TREE ROOT_ITEM 0) block 5557649408 gen 120361

	key (262 ROOT_BACKREF 257) block 5559844864 gen 120361

	key (1419 INODE_ITEM 0) block 5560958976 gen 120361

leaf 5557649408 items 32 free space 9608 generation 120361 owner ROOT_TREE

leaf 5557649408 flags 0x1(WRITTEN) backref revision 1

fs uuid cc072e56-f671-4388-a4a0-2ffee7c98fdb

chunk uuid 4c1e6100-2dd5-47a0-9aa8-58510884045f

	item 0 key (EXTENT_TREE ROOT_ITEM 0) itemoff 15844 itemsize 439

		generation 120361 root_dirid 0 bytenr 5557747712 byte_limit 0 bytes_used 54362112

		last_snapshot 0 flags 0x0(none) refs 1

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 2 generation_v2 120361

		uuid 00000000-0000-0000-0000-000000000000

		parent_uuid 00000000-0000-0000-0000-000000000000

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 0 otransid 0 stransid 0 rtransid 0

		ctime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 1 key (DEV_TREE ROOT_ITEM 0) itemoff 15405 itemsize 439

		generation 120350 root_dirid 0 bytenr 5562318848 byte_limit 0 bytes_used 16384

		last_snapshot 0 flags 0x0(none) refs 1

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 0 generation_v2 120350

		uuid 00000000-0000-0000-0000-000000000000

		parent_uuid 00000000-0000-0000-0000-000000000000

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 0 otransid 0 stransid 0 rtransid 0

		ctime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 2 key (FS_TREE INODE_REF 6) itemoff 15388 itemsize 17

		index 0 namelen 7 name: default

	item 3 key (FS_TREE ROOT_ITEM 0) itemoff 14949 itemsize 439

		generation 96051 root_dirid 256 bytenr 5545361408 byte_limit 0 bytes_used 16384

		last_snapshot 79338 flags 0x0(none) refs 1

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 0 generation_v2 96051

		uuid 00000000-0000-0000-0000-000000000000

		parent_uuid 00000000-0000-0000-0000-000000000000

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 96051 otransid 0 stransid 0 rtransid 0

		ctime 1622959702.608571752 (2021-06-06 06:08:22)

		otime 0.0 (1970-01-01 00:00:00)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 4 key (FS_TREE ROOT_REF 257) itemoff 14930 itemsize 19

		root ref key dirid 256 sequence 2 name @

	item 5 key (ROOT_TREE_DIR INODE_ITEM 0) itemoff 14770 itemsize 160

		generation 3 transid 0 size 0 nbytes 16384

		block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0

		sequence 0 flags 0x0(none)

		atime 1501439889.0 (2017-07-30 18:38:09)

		ctime 1501439889.0 (2017-07-30 18:38:09)

		mtime 1501439889.0 (2017-07-30 18:38:09)

		otime 1501439889.0 (2017-07-30 18:38:09)

	item 6 key (ROOT_TREE_DIR INODE_REF 6) itemoff 14758 itemsize 12

		index 0 namelen 2 name: ..

	item 7 key (ROOT_TREE_DIR DIR_ITEM 2378154706) itemoff 14721 itemsize 37

		location key (259 ROOT_ITEM 11) type DIR

		transid 0 data_len 0 name_len 7

		name: default

	item 8 key (CSUM_TREE ROOT_ITEM 0) itemoff 14282 itemsize 439

		generation 120361 root_dirid 0 bytenr 5560172544 byte_limit 0 bytes_used 35782656

		last_snapshot 0 flags 0x0(none) refs 1

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 2 generation_v2 120361

		uuid 00000000-0000-0000-0000-000000000000

		parent_uuid 00000000-0000-0000-0000-000000000000

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 0 otransid 0 stransid 0 rtransid 0

		ctime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 9 key (QUOTA_TREE ROOT_ITEM 0) itemoff 13843 itemsize 439

		generation 120361 root_dirid 0 bytenr 5557469184 byte_limit 0 bytes_used 16384

		last_snapshot 0 flags 0x0(none) refs 1

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 0 generation_v2 120361

		uuid 00000000-0000-0000-0000-000000000000

		parent_uuid 00000000-0000-0000-0000-000000000000

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 0 otransid 0 stransid 0 rtransid 0

		ctime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 10 key (UUID_TREE ROOT_ITEM 0) itemoff 13404 itemsize 439

		generation 120210 root_dirid 0 bytenr 248994725888 byte_limit 0 bytes_used 16384

		last_snapshot 0 flags 0x0(none) refs 1

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 0 generation_v2 120210

		uuid c016daa3-a4b2-9046-a525-8bbb8ce5105f

		parent_uuid 00000000-0000-0000-0000-000000000000

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 0 otransid 0 stransid 0 rtransid 0

		ctime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 11 key (257 ROOT_ITEM 0) itemoff 12965 itemsize 439

		generation 96090 root_dirid 256 bytenr 245349728256 byte_limit 0 bytes_used 16384

		last_snapshot 33 flags 0x0(none) refs 1

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 0 generation_v2 96090

		uuid 257f04e8-e972-1a42-956f-1252b88713a4

		parent_uuid 00000000-0000-0000-0000-000000000000

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 96090 otransid 7 stransid 0 rtransid 0

		ctime 1622962394.404213247 (2021-06-06 06:53:14)

		otime 1501439890.44000000 (2017-07-30 18:38:10)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 12 key (257 ROOT_BACKREF 5) itemoff 12946 itemsize 19

		root backref key dirid 256 sequence 2 name @

	item 13 key (257 ROOT_REF 258) itemoff 12918 itemsize 28

		root ref key dirid 256 sequence 3 name .snapshots

	item 14 key (257 ROOT_REF 260) itemoff 12893 itemsize 25

		root ref key dirid 262 sequence 2 name i386-pc

	item 15 key (257 ROOT_REF 261) itemoff 12865 itemsize 28

		root ref key dirid 262 sequence 3 name x86_64-efi

	item 16 key (257 ROOT_REF 262) itemoff 12843 itemsize 22

		root ref key dirid 256 sequence 5 name home

	item 17 key (257 ROOT_REF 263) itemoff 12822 itemsize 21

		root ref key dirid 256 sequence 6 name opt

	item 18 key (257 ROOT_REF 264) itemoff 12801 itemsize 21

		root ref key dirid 256 sequence 7 name srv

	item 19 key (257 ROOT_REF 265) itemoff 12780 itemsize 21

		root ref key dirid 256 sequence 8 name tmp

	item 20 key (257 ROOT_REF 266) itemoff 12757 itemsize 23

		root ref key dirid 263 sequence 2 name local

	item 21 key (257 ROOT_REF 1411) itemoff 12736 itemsize 21

		root ref key dirid 256 sequence 12 name var

	item 22 key (258 ROOT_ITEM 0) itemoff 12297 itemsize 439

		generation 120342 root_dirid 256 bytenr 5566021632 byte_limit 0 bytes_used 16384

		last_snapshot 87308 flags 0x0(none) refs 1

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 0 generation_v2 120342

		uuid 2b9cfacf-5c3d-924e-90e6-8f01818df659

		parent_uuid 00000000-0000-0000-0000-000000000000

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 120342 otransid 10 stransid 0 rtransid 0

		ctime 1644519173.499359965 (2022-02-10 18:52:53)

		otime 1501439890.672000000 (2017-07-30 18:38:10)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 23 key (258 ROOT_BACKREF 257) itemoff 12269 itemsize 28

		root backref key dirid 256 sequence 3 name .snapshots

	item 24 key (258 ROOT_REF 259) itemoff 12243 itemsize 26

		root ref key dirid 257 sequence 2 name snapshot

	item 25 key (259 ROOT_ITEM 11) itemoff 11804 itemsize 439

		generation 120360 root_dirid 256 bytenr 5597970432 byte_limit 0 bytes_used 322437120

		last_snapshot 119894 flags 0x0(none) refs 1

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 2 generation_v2 120360

		uuid 52afd41d-c722-4e48-b020-5b95a2d6fd84

		parent_uuid 257f04e8-e972-1a42-956f-1252b88713a4

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 120360 otransid 11 stransid 0 rtransid 0

		ctime 1644554759.875107191 (2022-02-11 04:45:59)

		otime 1501439890.732000000 (2017-07-30 18:38:10)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 26 key (259 ROOT_BACKREF 258) itemoff 11778 itemsize 26

		root backref key dirid 257 sequence 2 name snapshot

	item 27 key (260 ROOT_ITEM 0) itemoff 11339 itemsize 439

		generation 120221 root_dirid 256 bytenr 248944656384 byte_limit 0 bytes_used 294912

		last_snapshot 32854 flags 0x0(none) refs 1

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 1 generation_v2 120221

		uuid 40812ba2-102c-ae42-bf07-2b51e531d923

		parent_uuid 00000000-0000-0000-0000-000000000000

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 120221 otransid 14 stransid 0 rtransid 0

		ctime 1644431679.363044314 (2022-02-09 18:34:39)

		otime 1501439891.484000000 (2017-07-30 18:38:11)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 28 key (260 ROOT_BACKREF 257) itemoff 11314 itemsize 25

		root backref key dirid 262 sequence 2 name i386-pc

	item 29 key (261 ROOT_ITEM 0) itemoff 10875 itemsize 439

		generation 120221 root_dirid 256 bytenr 248944689152 byte_limit 0 bytes_used 16384

		last_snapshot 15 flags 0x0(none) refs 1

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 0 generation_v2 120221

		uuid 9105e591-b3d9-a84a-93e9-6902fd78897b

		parent_uuid 00000000-0000-0000-0000-000000000000

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 120221 otransid 15 stransid 0 rtransid 0

		ctime 1644431679.371276266 (2022-02-09 18:34:39)

		otime 1501439891.572000000 (2017-07-30 18:38:11)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 30 key (261 ROOT_BACKREF 257) itemoff 10847 itemsize 28

		root backref key dirid 262 sequence 3 name x86_64-efi

	item 31 key (262 ROOT_ITEM 0) itemoff 10408 itemsize 439

		generation 120360 root_dirid 256 bytenr 5558403072 byte_limit 0 bytes_used 46186496

		last_snapshot 87355 flags 0x0(none) refs 1

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 2 generation_v2 120360

		uuid be0f25f1-8505-7a4d-87bf-29bcb06ce55c

		parent_uuid 00000000-0000-0000-0000-000000000000

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 120359 otransid 16 stransid 0 rtransid 0

		ctime 1644554753.712422204 (2022-02-11 04:45:53)

		otime 1501439891.644000000 (2017-07-30 18:38:11)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

leaf 5559844864 items 100 free space 318 generation 120361 owner ROOT_TREE

leaf 5559844864 flags 0x1(WRITTEN) backref revision 1

fs uuid cc072e56-f671-4388-a4a0-2ffee7c98fdb

chunk uuid 4c1e6100-2dd5-47a0-9aa8-58510884045f

	item 0 key (262 ROOT_BACKREF 257) itemoff 16261 itemsize 22

		root backref key dirid 256 sequence 5 name home

	item 1 key (263 ROOT_ITEM 0) itemoff 15822 itemsize 439

		generation 120186 root_dirid 256 bytenr 5661507584 byte_limit 0 bytes_used 16384

		last_snapshot 13469 flags 0x0(none) refs 1

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 0 generation_v2 120186

		uuid e95e8fd5-5bc0-e94a-bc56-c355357479dc

		parent_uuid 00000000-0000-0000-0000-000000000000

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 120186 otransid 17 stransid 0 rtransid 0

		ctime 1644430801.696011418 (2022-02-09 18:20:01)

		otime 1501439891.716000000 (2017-07-30 18:38:11)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 2 key (263 ROOT_BACKREF 257) itemoff 15801 itemsize 21

		root backref key dirid 256 sequence 6 name opt

	item 3 key (264 ROOT_ITEM 0) itemoff 15362 itemsize 439

		generation 120221 root_dirid 256 bytenr 248944820224 byte_limit 0 bytes_used 16384

		last_snapshot 76 flags 0x0(none) refs 1

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 0 generation_v2 120221

		uuid 4b0f5496-dc32-9d43-a36c-333b18b9370c

		parent_uuid 00000000-0000-0000-0000-000000000000

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 120221 otransid 18 stransid 0 rtransid 0

		ctime 1644431681.579233921 (2022-02-09 18:34:41)

		otime 1501439891.860000000 (2017-07-30 18:38:11)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 4 key (264 ROOT_BACKREF 257) itemoff 15341 itemsize 21

		root backref key dirid 256 sequence 7 name srv

	item 5 key (265 ROOT_ITEM 0) itemoff 14902 itemsize 439

		generation 120360 root_dirid 256 bytenr 5597691904 byte_limit 0 bytes_used 16384

		last_snapshot 87358 flags 0x0(none) refs 1

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 0 generation_v2 120360

		uuid d658c9bd-dbe2-e842-9e31-c943119b725f

		parent_uuid 00000000-0000-0000-0000-000000000000

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 120360 otransid 19 stransid 0 rtransid 0

		ctime 1644554762.563236625 (2022-02-11 04:46:02)

		otime 1501439891.992000000 (2017-07-30 18:38:11)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 6 key (265 ROOT_BACKREF 257) itemoff 14881 itemsize 21

		root backref key dirid 256 sequence 8 name tmp

	item 7 key (266 ROOT_ITEM 0) itemoff 14442 itemsize 439

		generation 120221 root_dirid 256 bytenr 248944836608 byte_limit 0 bytes_used 16384

		last_snapshot 70559 flags 0x0(none) refs 1

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 0 generation_v2 120221

		uuid 71717a12-5b0c-8240-9ef4-907586ed935c

		parent_uuid 00000000-0000-0000-0000-000000000000

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 120221 otransid 20 stransid 0 rtransid 0

		ctime 1644431681.579819896 (2022-02-09 18:34:41)

		otime 1501439892.148000000 (2017-07-30 18:38:12)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 8 key (266 ROOT_BACKREF 257) itemoff 14419 itemsize 23

		root backref key dirid 263 sequence 2 name local

	item 9 key (280 INODE_ITEM 0) itemoff 14259 itemsize 160

		generation 120361 transid 120361 size 262144 nbytes 23696769024

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 90396 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644554769.52514755 (2022-02-11 04:46:09)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 10 key (280 EXTENT_DATA 0) itemoff 14206 itemsize 53

		generation 120361 type 1 (regular)

		extent data disk byte 1663336448 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 11 key (281 INODE_ITEM 0) itemoff 14046 itemsize 160

		generation 120360 transid 120360 size 262144 nbytes 19963576320

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 76155 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644554768.176515963 (2022-02-11 04:46:08)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 12 key (281 EXTENT_DATA 0) itemoff 13993 itemsize 53

		generation 120360 type 1 (regular)

		extent data disk byte 2357436416 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 13 key (282 INODE_ITEM 0) itemoff 13833 itemsize 160

		generation 120261 transid 120261 size 262144 nbytes 17587503104

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 67091 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644513304.614646736 (2022-02-10 17:15:04)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 14 key (282 EXTENT_DATA 0) itemoff 13780 itemsize 53

		generation 120261 type 1 (regular)

		extent data disk byte 2012721152 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 15 key (283 INODE_ITEM 0) itemoff 13620 itemsize 160

		generation 120351 transid 120351 size 262144 nbytes 15409086464

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 58781 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644554383.7802107 (2022-02-11 04:39:43)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 16 key (283 EXTENT_DATA 0) itemoff 13567 itemsize 53

		generation 120351 type 1 (regular)

		extent data disk byte 2079834112 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 17 key (285 INODE_ITEM 0) itemoff 13407 itemsize 160

		generation 120361 transid 120361 size 65536 nbytes 4540923904

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 69289 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644554769.52514755 (2022-02-11 04:46:09)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 18 key (285 EXTENT_DATA 0) itemoff 13354 itemsize 53

		generation 120361 type 1 (regular)

		extent data disk byte 1200144384 nr 65536

		extent data offset 0 nr 65536 ram 65536

		extent compression 0 (none)

	item 19 key (288 INODE_ITEM 0) itemoff 13194 itemsize 160

		generation 120327 transid 120327 size 65536 nbytes 4459659264

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 68049 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644518581.817493062 (2022-02-10 18:43:01)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 20 key (288 EXTENT_DATA 0) itemoff 13141 itemsize 53

		generation 120327 type 1 (regular)

		extent data disk byte 1200975872 nr 65536

		extent data offset 0 nr 65536 ram 65536

		extent compression 0 (none)

	item 21 key (301 INODE_ITEM 0) itemoff 12981 itemsize 160

		generation 120295 transid 120295 size 65536 nbytes 4268097536

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 65126 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644515571.673243304 (2022-02-10 17:52:51)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 22 key (301 EXTENT_DATA 0) itemoff 12928 itemsize 53

		generation 120295 type 1 (regular)

		extent data disk byte 1206738944 nr 65536

		extent data offset 0 nr 65536 ram 65536

		extent compression 0 (none)

	item 23 key (302 INODE_ITEM 0) itemoff 12768 itemsize 160

		generation 120350 transid 120350 size 262144 nbytes 11281891328

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 43037 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644554348.407352382 (2022-02-11 04:39:08)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 24 key (302 EXTENT_DATA 0) itemoff 12715 itemsize 53

		generation 120350 type 1 (regular)

		extent data disk byte 1667424256 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 25 key (339 INODE_ITEM 0) itemoff 12555 itemsize 160

		generation 120312 transid 120312 size 65536 nbytes 4025679872

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 61427 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644516893.653958690 (2022-02-10 18:14:53)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 26 key (339 EXTENT_DATA 0) itemoff 12502 itemsize 53

		generation 120312 type 1 (regular)

		extent data disk byte 1200246784 nr 65536

		extent data offset 0 nr 65536 ram 65536

		extent compression 0 (none)

	item 27 key (354 INODE_ITEM 0) itemoff 12342 itemsize 160

		generation 120333 transid 120333 size 65536 nbytes 3746234368

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 57163 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644518807.858422098 (2022-02-10 18:46:47)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 28 key (354 EXTENT_DATA 0) itemoff 12289 itemsize 53

		generation 120333 type 1 (regular)

		extent data disk byte 1180880896 nr 65536

		extent data offset 0 nr 65536 ram 65536

		extent compression 0 (none)

	item 29 key (359 INODE_ITEM 0) itemoff 12129 itemsize 160

		generation 120350 transid 120350 size 262144 nbytes 7813726208

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 29807 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644554348.407352382 (2022-02-11 04:39:08)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 30 key (359 EXTENT_DATA 0) itemoff 12076 itemsize 53

		generation 120350 type 1 (regular)

		extent data disk byte 2293637120 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 31 key (373 INODE_ITEM 0) itemoff 11916 itemsize 160

		generation 120263 transid 120263 size 65536 nbytes 3597991936

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 54901 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644513372.159850335 (2022-02-10 17:16:12)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 32 key (373 EXTENT_DATA 0) itemoff 11863 itemsize 53

		generation 120263 type 1 (regular)

		extent data disk byte 1244680192 nr 65536

		extent data offset 0 nr 65536 ram 65536

		extent compression 0 (none)

	item 33 key (401 INODE_ITEM 0) itemoff 11703 itemsize 160

		generation 120263 transid 120263 size 262144 nbytes 8675131392

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 33093 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644513372.159850335 (2022-02-10 17:16:12)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 34 key (401 EXTENT_DATA 0) itemoff 11650 itemsize 53

		generation 120263 type 1 (regular)

		extent data disk byte 2245107712 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 35 key (449 INODE_ITEM 0) itemoff 11490 itemsize 160

		generation 120329 transid 120329 size 262144 nbytes 8474853376

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 32329 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644518647.347602718 (2022-02-10 18:44:07)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 36 key (449 EXTENT_DATA 0) itemoff 11437 itemsize 53

		generation 120329 type 1 (regular)

		extent data disk byte 2316058624 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 37 key (501 INODE_ITEM 0) itemoff 11277 itemsize 160

		generation 120263 transid 120263 size 262144 nbytes 5993660416

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 22864 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644513372.171851060 (2022-02-10 17:16:12)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 38 key (501 EXTENT_DATA 0) itemoff 11224 itemsize 53

		generation 120263 type 1 (regular)

		extent data disk byte 2431508480 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 39 key (532 INODE_ITEM 0) itemoff 11064 itemsize 160

		generation 120329 transid 120329 size 262144 nbytes 5978193920

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 22805 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644518647.347602718 (2022-02-10 18:44:07)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 40 key (532 EXTENT_DATA 0) itemoff 11011 itemsize 53

		generation 120329 type 1 (regular)

		extent data disk byte 2318729216 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 41 key (563 INODE_ITEM 0) itemoff 10851 itemsize 160

		generation 120265 transid 120265 size 65536 nbytes 3890675712

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 59367 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644513439.709920244 (2022-02-10 17:17:19)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 42 key (563 EXTENT_DATA 0) itemoff 10798 itemsize 53

		generation 120265 type 1 (regular)

		extent data disk byte 1235980288 nr 65536

		extent data offset 0 nr 65536 ram 65536

		extent compression 0 (none)

	item 43 key (564 INODE_ITEM 0) itemoff 10638 itemsize 160

		generation 120329 transid 120329 size 262144 nbytes 6516375552

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 24858 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644518647.351602644 (2022-02-10 18:44:07)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 44 key (564 EXTENT_DATA 0) itemoff 10585 itemsize 53

		generation 120329 type 1 (regular)

		extent data disk byte 2344456192 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 45 key (638 INODE_ITEM 0) itemoff 10425 itemsize 160

		generation 19739 transid 19739 size 262144 nbytes 60555264

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 231 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1546596311.523144630 (2019-01-04 10:05:11)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 46 key (638 EXTENT_DATA 0) itemoff 10372 itemsize 53

		generation 19739 type 1 (regular)

		extent data disk byte 1611452416 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 47 key (664 INODE_ITEM 0) itemoff 10212 itemsize 160

		generation 120263 transid 120263 size 262144 nbytes 4419747840

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 16860 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644513372.163850577 (2022-02-10 17:16:12)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 48 key (664 EXTENT_DATA 0) itemoff 10159 itemsize 53

		generation 120263 type 1 (regular)

		extent data disk byte 2372616192 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 49 key (685 INODE_ITEM 0) itemoff 9999 itemsize 160

		generation 120256 transid 120256 size 262144 nbytes 4157341696

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 15859 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644432981.247013911 (2022-02-09 18:56:21)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 50 key (685 EXTENT_DATA 0) itemoff 9946 itemsize 53

		generation 120256 type 1 (regular)

		extent data disk byte 1972322304 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 51 key (740 INODE_ITEM 0) itemoff 9786 itemsize 160

		generation 120354 transid 120354 size 262144 nbytes 3961782272

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 15113 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644554488.213968296 (2022-02-11 04:41:28)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 52 key (740 EXTENT_DATA 0) itemoff 9733 itemsize 53

		generation 120354 type 1 (regular)

		extent data disk byte 2294693888 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 53 key (810 INODE_ITEM 0) itemoff 9573 itemsize 160

		generation 120350 transid 120350 size 262144 nbytes 2772434944

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 10576 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644554348.423352025 (2022-02-11 04:39:08)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 54 key (810 EXTENT_DATA 0) itemoff 9520 itemsize 53

		generation 120350 type 1 (regular)

		extent data disk byte 2212872192 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 55 key (1064 INODE_ITEM 0) itemoff 9360 itemsize 160

		generation 120276 transid 120276 size 262144 nbytes 2943352832

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 11228 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644514015.156819621 (2022-02-10 17:26:55)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 56 key (1064 EXTENT_DATA 0) itemoff 9307 itemsize 53

		generation 120276 type 1 (regular)

		extent data disk byte 1659392000 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 57 key (1223 INODE_ITEM 0) itemoff 9147 itemsize 160

		generation 120351 transid 120351 size 262144 nbytes 2684354560

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 10240 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644554383.27802278 (2022-02-11 04:39:43)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 58 key (1223 EXTENT_DATA 0) itemoff 9094 itemsize 53

		generation 120351 type 1 (regular)

		extent data disk byte 2139275264 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 59 key (1239 INODE_ITEM 0) itemoff 8934 itemsize 160

		generation 120360 transid 120360 size 262144 nbytes 1914961920

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 7305 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644554768.160515986 (2022-02-11 04:46:08)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 60 key (1239 EXTENT_DATA 0) itemoff 8881 itemsize 53

		generation 120360 type 1 (regular)

		extent data disk byte 1662251008 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 61 key (1292 INODE_ITEM 0) itemoff 8721 itemsize 160

		generation 120350 transid 120350 size 262144 nbytes 2019557376

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 7704 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644554348.435351756 (2022-02-11 04:39:08)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 62 key (1292 EXTENT_DATA 0) itemoff 8668 itemsize 53

		generation 120350 type 1 (regular)

		extent data disk byte 2364530688 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 63 key (1304 INODE_ITEM 0) itemoff 8508 itemsize 160

		generation 120360 transid 120360 size 262144 nbytes 987496448

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 3767 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644554768.160515986 (2022-02-11 04:46:08)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 64 key (1304 EXTENT_DATA 0) itemoff 8455 itemsize 53

		generation 120360 type 1 (regular)

		extent data disk byte 2293358592 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 65 key (1312 INODE_ITEM 0) itemoff 8295 itemsize 160

		generation 120277 transid 120277 size 262144 nbytes 1285554176

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 4904 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644514048.3604923 (2022-02-10 17:27:28)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 66 key (1312 EXTENT_DATA 0) itemoff 8242 itemsize 53

		generation 120277 type 1 (regular)

		extent data disk byte 1685733376 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 67 key (1327 INODE_ITEM 0) itemoff 8082 itemsize 160

		generation 120197 transid 120197 size 262144 nbytes 1063256064

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 4056 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644431155.6968358 (2022-02-09 18:25:55)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 68 key (1327 EXTENT_DATA 0) itemoff 8029 itemsize 53

		generation 120197 type 1 (regular)

		extent data disk byte 3146928128 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 69 key (1328 INODE_ITEM 0) itemoff 7869 itemsize 160

		generation 120197 transid 120197 size 262144 nbytes 367001600

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 1400 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644431155.6968358 (2022-02-09 18:25:55)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 70 key (1328 EXTENT_DATA 0) itemoff 7816 itemsize 53

		generation 120197 type 1 (regular)

		extent data disk byte 3155128320 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 71 key (1329 ROOT_ITEM 81748) itemoff 7377 itemsize 439

		generation 81749 root_dirid 256 bytenr 70449102848 byte_limit 0 bytes_used 313655296

		last_snapshot 81748 flags 0x1000000000001(RDONLY) refs 0

		drop_progress key (9414435 INODE_ITEM 0) drop_level 1

		level 2 generation_v2 81749

		uuid 2c5e44c6-cb4d-1b4f-a3f0-df1ee3509f47

		parent_uuid 52afd41d-c722-4e48-b020-5b95a2d6fd84

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 81748 otransid 81748 stransid 0 rtransid 0

		ctime 1614326844.216735782 (2021-02-26 08:07:24)

		otime 1614326844.284742808 (2021-02-26 08:07:24)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 72 key (1331 ROOT_ITEM 82831) itemoff 6938 itemsize 439

		generation 87340 root_dirid 256 bytenr 8514846720 byte_limit 0 bytes_used 313589760

		last_snapshot 82969 flags 0x1000000000001(RDONLY) refs 0

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 2 generation_v2 87340

		uuid f2a928cf-d243-774b-b2bb-4e80e3d37bdf

		parent_uuid 52afd41d-c722-4e48-b020-5b95a2d6fd84

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 82830 otransid 82831 stransid 0 rtransid 0

		ctime 1614330605.649484116 (2021-02-26 09:10:05)

		otime 1614330616.574128143 (2021-02-26 09:10:16)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 73 key (1332 ROOT_ITEM 82904) itemoff 6499 itemsize 439

		generation 87340 root_dirid 256 bytenr 8515452928 byte_limit 0 bytes_used 313589760

		last_snapshot 82969 flags 0x1000000000001(RDONLY) refs 0

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 2 generation_v2 87340

		uuid b9125452-fb5d-e14d-a79e-2a967b992ea1

		parent_uuid 52afd41d-c722-4e48-b020-5b95a2d6fd84

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 82904 otransid 82904 stransid 0 rtransid 0

		ctime 1614539496.823057032 (2021-02-28 19:11:36)

		otime 1614539499.212006544 (2021-02-28 19:11:39)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 74 key (1333 INODE_ITEM 0) itemoff 6339 itemsize 160

		generation 120197 transid 120197 size 262144 nbytes 807665664

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 3081 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644431155.6968358 (2022-02-09 18:25:55)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 75 key (1333 EXTENT_DATA 0) itemoff 6286 itemsize 53

		generation 120197 type 1 (regular)

		extent data disk byte 3178762240 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 76 key (1334 ROOT_ITEM 83008) itemoff 5847 itemsize 439

		generation 87340 root_dirid 256 bytenr 8514813952 byte_limit 0 bytes_used 289947648

		last_snapshot 83008 flags 0x1000000000001(RDONLY) refs 0

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 2 generation_v2 87340

		uuid 4b9ea638-b824-0c41-80eb-d0ca2060e9d7

		parent_uuid 52afd41d-c722-4e48-b020-5b95a2d6fd84

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 83008 otransid 83008 stransid 0 rtransid 0

		ctime 1614701776.154995904 (2021-03-02 16:16:16)

		otime 1614701777.493198821 (2021-03-02 16:16:17)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 77 key (1339 INODE_ITEM 0) itemoff 5687 itemsize 160

		generation 120197 transid 120197 size 262144 nbytes 1557135360

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 5940 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644431155.30968291 (2022-02-09 18:25:55)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 78 key (1339 EXTENT_DATA 0) itemoff 5634 itemsize 53

		generation 120197 type 1 (regular)

		extent data disk byte 3180728320 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 79 key (1341 INODE_ITEM 0) itemoff 5474 itemsize 160

		generation 120354 transid 120354 size 65536 nbytes 1539702784

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 23494 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644554488.213968296 (2022-02-11 04:41:28)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 80 key (1341 EXTENT_DATA 0) itemoff 5421 itemsize 53

		generation 120354 type 1 (regular)

		extent data disk byte 1171632128 nr 65536

		extent data offset 0 nr 65536 ram 65536

		extent compression 0 (none)

	item 81 key (1344 ROOT_ITEM 83882) itemoff 4982 itemsize 439

		generation 87340 root_dirid 256 bytenr 8514781184 byte_limit 0 bytes_used 314146816

		last_snapshot 83882 flags 0x1000000000001(RDONLY) refs 0

		drop_progress key (2019562 DIR_ITEM 2257636364) drop_level 1

		level 2 generation_v2 87340

		uuid c6e277b2-769b-fa4a-a65c-dca717f8650e

		parent_uuid 52afd41d-c722-4e48-b020-5b95a2d6fd84

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 83882 otransid 83882 stransid 0 rtransid 0

		ctime 1615559815.543051255 (2021-03-12 14:36:55)

		otime 1615559815.577716442 (2021-03-12 14:36:55)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 82 key (1346 INODE_ITEM 0) itemoff 4822 itemsize 160

		generation 120197 transid 120197 size 262144 nbytes 1023148032

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 3903 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644431155.30968291 (2022-02-09 18:25:55)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 83 key (1346 EXTENT_DATA 0) itemoff 4769 itemsize 53

		generation 120197 type 1 (regular)

		extent data disk byte 3184300032 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 84 key (1358 INODE_ITEM 0) itemoff 4609 itemsize 160

		generation 120260 transid 120260 size 262144 nbytes 2044461056

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 7799 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644513268.502674180 (2022-02-10 17:14:28)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 85 key (1358 EXTENT_DATA 0) itemoff 4556 itemsize 53

		generation 120260 type 1 (regular)

		extent data disk byte 2390872064 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 86 key (1365 INODE_ITEM 0) itemoff 4396 itemsize 160

		generation 120347 transid 120347 size 262144 nbytes 2086666240

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 7960 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644519281.646922730 (2022-02-10 18:54:41)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 87 key (1365 EXTENT_DATA 0) itemoff 4343 itemsize 53

		generation 120347 type 1 (regular)

		extent data disk byte 1696747520 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 88 key (1371 INODE_ITEM 0) itemoff 4183 itemsize 160

		generation 120360 transid 120360 size 65536 nbytes 1103757312

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 16842 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644554768.176515963 (2022-02-11 04:46:08)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 89 key (1371 EXTENT_DATA 0) itemoff 4130 itemsize 53

		generation 120360 type 1 (regular)

		extent data disk byte 1169944576 nr 65536

		extent data offset 0 nr 65536 ram 65536

		extent compression 0 (none)

	item 90 key (1385 INODE_ITEM 0) itemoff 3970 itemsize 160

		generation 120196 transid 120196 size 262144 nbytes 1631846400

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 6225 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644431131.823034230 (2022-02-09 18:25:31)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 91 key (1385 EXTENT_DATA 0) itemoff 3917 itemsize 53

		generation 120196 type 1 (regular)

		extent data disk byte 2830856192 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 92 key (1390 INODE_ITEM 0) itemoff 3757 itemsize 160

		generation 120201 transid 120201 size 262144 nbytes 1704984576

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 6504 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644431252.238731560 (2022-02-09 18:27:32)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 93 key (1390 EXTENT_DATA 0) itemoff 3704 itemsize 53

		generation 120201 type 1 (regular)

		extent data disk byte 1690120192 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 94 key (1411 ROOT_ITEM 0) itemoff 3265 itemsize 439

		generation 120360 root_dirid 256 bytenr 5562613760 byte_limit 0 bytes_used 6373376

		last_snapshot 0 flags 0x0(none) refs 1

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 2 generation_v2 120360

		uuid f5f4dae5-fdbc-9141-8fba-83e95b9ea132

		parent_uuid 00000000-0000-0000-0000-000000000000

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 120360 otransid 96059 stransid 0 rtransid 0

		ctime 1644554768.162863730 (2022-02-11 04:46:08)

		otime 1622960837.720000000 (2021-06-06 06:27:17)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)

	item 95 key (1411 ROOT_BACKREF 257) itemoff 3244 itemsize 21

		root backref key dirid 256 sequence 12 name var

	item 96 key (1413 INODE_ITEM 0) itemoff 3084 itemsize 160

		generation 120197 transid 120197 size 262144 nbytes 3679977472

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 14038 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644431155.30968291 (2022-02-09 18:25:55)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 97 key (1413 EXTENT_DATA 0) itemoff 3031 itemsize 53

		generation 120197 type 1 (regular)

		extent data disk byte 3222929408 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 98 key (1414 INODE_ITEM 0) itemoff 2871 itemsize 160

		generation 120211 transid 120211 size 262144 nbytes 1150287872

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 4388 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644431446.722311032 (2022-02-09 18:30:46)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 99 key (1414 EXTENT_DATA 0) itemoff 2818 itemsize 53

		generation 120211 type 1 (regular)

		extent data disk byte 2417995776 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

leaf 5560958976 items 69 free space 10152 generation 120361 owner ROOT_TREE

leaf 5560958976 flags 0x1(WRITTEN) backref revision 1

fs uuid cc072e56-f671-4388-a4a0-2ffee7c98fdb

chunk uuid 4c1e6100-2dd5-47a0-9aa8-58510884045f

	item 0 key (1419 INODE_ITEM 0) itemoff 16123 itemsize 160

		generation 120316 transid 120316 size 65536 nbytes 691863552

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 10557 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644517042.922287703 (2022-02-10 18:17:22)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 1 key (1419 EXTENT_DATA 0) itemoff 16070 itemsize 53

		generation 120316 type 1 (regular)

		extent data disk byte 1206358016 nr 65536

		extent data offset 0 nr 65536 ram 65536

		extent compression 0 (none)

	item 2 key (1514 INODE_ITEM 0) itemoff 15910 itemsize 160

		generation 120211 transid 120211 size 65536 nbytes 319160320

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 4870 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644431446.722311032 (2022-02-09 18:30:46)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 3 key (1514 EXTENT_DATA 0) itemoff 15857 itemsize 53

		generation 120211 type 1 (regular)

		extent data disk byte 1261604864 nr 65536

		extent data offset 0 nr 65536 ram 65536

		extent compression 0 (none)

	item 4 key (1537 INODE_ITEM 0) itemoff 15697 itemsize 160

		generation 120232 transid 120232 size 262144 nbytes 900988928

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 3437 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644432014.663294467 (2022-02-09 18:40:14)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 5 key (1537 EXTENT_DATA 0) itemoff 15644 itemsize 53

		generation 120232 type 1 (regular)

		extent data disk byte 2172416000 nr 262144

		extent data offset 0 nr 262144 ram 262144

		extent compression 0 (none)

	item 6 key (1544 INODE_ITEM 0) itemoff 15484 itemsize 160

		generation 120120 transid 120120 size 196608 nbytes 105185280

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 535 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644381970.824638079 (2022-02-09 04:46:10)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 7 key (1544 EXTENT_DATA 0) itemoff 15431 itemsize 53

		generation 120120 type 1 (regular)

		extent data disk byte 2364272640 nr 196608

		extent data offset 0 nr 196608 ram 196608

		extent compression 0 (none)

	item 8 key (1545 INODE_ITEM 0) itemoff 15271 itemsize 160

		generation 119883 transid 119883 size 65536 nbytes 14745600

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 225 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644357364.696000000 (2022-02-08 21:56:04)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 9 key (1545 EXTENT_DATA 0) itemoff 15218 itemsize 53

		generation 119883 type 1 (regular)

		extent data disk byte 58440540160 nr 65536

		extent data offset 0 nr 65536 ram 65536

		extent compression 0 (none)

	item 10 key (1546 INODE_ITEM 0) itemoff 15058 itemsize 160

		generation 120120 transid 120120 size 65536 nbytes 11010048

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 168 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644381970.836638101 (2022-02-09 04:46:10)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 11 key (1546 EXTENT_DATA 0) itemoff 15005 itemsize 53

		generation 120120 type 1 (regular)

		extent data disk byte 1532309504 nr 65536

		extent data offset 0 nr 65536 ram 65536

		extent compression 0 (none)

	item 12 key (1547 INODE_ITEM 0) itemoff 14845 itemsize 160

		generation 120211 transid 120211 size 65536 nbytes 6422528

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 98 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644431446.722311032 (2022-02-09 18:30:46)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 13 key (1547 EXTENT_DATA 0) itemoff 14792 itemsize 53

		generation 120211 type 1 (regular)

		extent data disk byte 1265504256 nr 65536

		extent data offset 0 nr 65536 ram 65536

		extent compression 0 (none)

	item 14 key (1548 INODE_ITEM 0) itemoff 14632 itemsize 160

		generation 120211 transid 120211 size 65536 nbytes 851968

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 13 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644431446.722311032 (2022-02-09 18:30:46)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 15 key (1548 EXTENT_DATA 0) itemoff 14579 itemsize 53

		generation 120211 type 1 (regular)

		extent data disk byte 1269886976 nr 65536

		extent data offset 0 nr 65536 ram 65536

		extent compression 0 (none)

	item 16 key (1549 INODE_ITEM 0) itemoff 14419 itemsize 160

		generation 120211 transid 120211 size 65536 nbytes 458752

		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

		sequence 7 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)

		atime 0.0 (1970-01-01 00:00:00)

		ctime 1644431446.722311032 (2022-02-09 18:30:46)

		mtime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

	item 17 key (1549 EXTENT_DATA 0) itemoff 14366 itemsize 53

		generation 120211 type 1 (regular)

		extent data disk byte 1270173696 nr 65536

		extent data offset 0 nr 65536 ram 65536

		extent compression 0 (none)

	item 18 key (FREE_SPACE UNTYPED 1103101952) itemoff 14325 itemsize 41

		location key (280 INODE_ITEM 0)

		cache generation 120361 entries 415 bitmaps 8

	item 19 key (FREE_SPACE UNTYPED 2176843776) itemoff 14284 itemsize 41

		location key (281 INODE_ITEM 0)

		cache generation 120360 entries 417 bitmaps 8

	item 20 key (FREE_SPACE UNTYPED 3250585600) itemoff 14243 itemsize 41

		location key (282 INODE_ITEM 0)

		cache generation 120261 entries 417 bitmaps 8

	item 21 key (FREE_SPACE UNTYPED 4324327424) itemoff 14202 itemsize 41

		location key (283 INODE_ITEM 0)

		cache generation 120351 entries 416 bitmaps 8

	item 22 key (FREE_SPACE UNTYPED 5532286976) itemoff 14161 itemsize 41

		location key (285 INODE_ITEM 0)

		cache generation 120361 entries 229 bitmaps 1

	item 23 key (FREE_SPACE UNTYPED 5968494592) itemoff 14120 itemsize 41

		location key (288 INODE_ITEM 0)

		cache generation 120327 entries 426 bitmaps 1

	item 24 key (FREE_SPACE UNTYPED 8417968128) itemoff 14079 itemsize 41

		location key (301 INODE_ITEM 0)

		cache generation 120295 entries 370 bitmaps 1

	item 25 key (FREE_SPACE UNTYPED 8552185856) itemoff 14038 itemsize 41

		location key (302 INODE_ITEM 0)

		cache generation 120350 entries 426 bitmaps 8

	item 26 key (FREE_SPACE UNTYPED 15699279872) itemoff 13997 itemsize 41

		location key (339 INODE_ITEM 0)

		cache generation 120312 entries 390 bitmaps 1

	item 27 key (FREE_SPACE UNTYPED 18316525568) itemoff 13956 itemsize 41

		location key (354 INODE_ITEM 0)

		cache generation 120333 entries 339 bitmaps 1

	item 28 key (FREE_SPACE UNTYPED 19658702848) itemoff 13915 itemsize 41

		location key (359 INODE_ITEM 0)

		cache generation 120350 entries 441 bitmaps 7

	item 29 key (FREE_SPACE UNTYPED 23349690368) itemoff 13874 itemsize 41

		location key (373 INODE_ITEM 0)

		cache generation 120263 entries 428 bitmaps 1

	item 30 key (FREE_SPACE UNTYPED 27845984256) itemoff 13833 itemsize 41

		location key (401 INODE_ITEM 0)

		cache generation 120263 entries 464 bitmaps 8

	item 31 key (FREE_SPACE UNTYPED 38717620224) itemoff 13792 itemsize 41

		location key (449 INODE_ITEM 0)

		cache generation 120329 entries 469 bitmaps 8

	item 32 key (FREE_SPACE UNTYPED 52474937344) itemoff 13751 itemsize 41

		location key (501 INODE_ITEM 0)

		cache generation 120263 entries 453 bitmaps 8

	item 33 key (FREE_SPACE UNTYPED 58179190784) itemoff 13710 itemsize 41

		location key (532 INODE_ITEM 0)

		cache generation 120329 entries 464 bitmaps 8

	item 34 key (FREE_SPACE UNTYPED 70292340736) itemoff 13669 itemsize 41

		location key (563 INODE_ITEM 0)

		cache generation 120265 entries 413 bitmaps 2

	item 35 key (FREE_SPACE UNTYPED 70560776192) itemoff 13628 itemsize 41

		location key (564 INODE_ITEM 0)

		cache generation 120329 entries 442 bitmaps 8

	item 36 key (FREE_SPACE UNTYPED 91733622784) itemoff 13587 itemsize 41

		location key (664 INODE_ITEM 0)

		cache generation 120263 entries 413 bitmaps 7

	item 37 key (FREE_SPACE UNTYPED 102907248640) itemoff 13546 itemsize 41

		location key (685 INODE_ITEM 0)

		cache generation 120256 entries 355 bitmaps 6

	item 38 key (FREE_SPACE UNTYPED 118879158272) itemoff 13505 itemsize 41

		location key (740 INODE_ITEM 0)

		cache generation 120354 entries 390 bitmaps 6

	item 39 key (FREE_SPACE UNTYPED 134817513472) itemoff 13464 itemsize 41

		location key (810 INODE_ITEM 0)

		cache generation 120350 entries 202 bitmaps 4

	item 40 key (FREE_SPACE UNTYPED 190954078208) itemoff 13423 itemsize 41

		location key (1064 INODE_ITEM 0)

		cache generation 120276 entries 119 bitmaps 0

	item 41 key (FREE_SPACE UNTYPED 220616196096) itemoff 13382 itemsize 41

		location key (1223 INODE_ITEM 0)

		cache generation 120351 entries 150 bitmaps 2

	item 42 key (FREE_SPACE UNTYPED 223870976000) itemoff 13341 itemsize 41

		location key (1239 INODE_ITEM 0)

		cache generation 120360 entries 262 bitmaps 6

	item 43 key (FREE_SPACE UNTYPED 230414090240) itemoff 13300 itemsize 41

		location key (1292 INODE_ITEM 0)

		cache generation 120350 entries 125 bitmaps 0

	item 44 key (FREE_SPACE UNTYPED 233064890368) itemoff 13259 itemsize 41

		location key (1304 INODE_ITEM 0)

		cache generation 120360 entries 99 bitmaps 1

	item 45 key (FREE_SPACE UNTYPED 235883462656) itemoff 13218 itemsize 41

		location key (1312 INODE_ITEM 0)

		cache generation 120277 entries 14 bitmaps 0

	item 46 key (FREE_SPACE UNTYPED 237963837440) itemoff 13177 itemsize 41

		location key (1327 INODE_ITEM 0)

		cache generation 120197 entries 95 bitmaps 0

	item 47 key (FREE_SPACE UNTYPED 239037579264) itemoff 13136 itemsize 41

		location key (1328 INODE_ITEM 0)

		cache generation 120197 entries 118 bitmaps 0

	item 48 key (FREE_SPACE UNTYPED 241185062912) itemoff 13095 itemsize 41

		location key (1333 INODE_ITEM 0)

		cache generation 120197 entries 316 bitmaps 1

	item 49 key (FREE_SPACE UNTYPED 243768754176) itemoff 13054 itemsize 41

		location key (1339 INODE_ITEM 0)

		cache generation 120197 entries 199 bitmaps 0

	item 50 key (FREE_SPACE UNTYPED 245245149184) itemoff 13013 itemsize 41

		location key (1341 INODE_ITEM 0)

		cache generation 120354 entries 412 bitmaps 2

	item 51 key (FREE_SPACE UNTYPED 245714911232) itemoff 12972 itemsize 41

		location key (1346 INODE_ITEM 0)

		cache generation 120197 entries 343 bitmaps 1

	item 52 key (FREE_SPACE UNTYPED 246788653056) itemoff 12931 itemsize 41

		location key (1358 INODE_ITEM 0)

		cache generation 120260 entries 77 bitmaps 0

	item 53 key (FREE_SPACE UNTYPED 247862394880) itemoff 12890 itemsize 41

		location key (1365 INODE_ITEM 0)

		cache generation 120347 entries 62 bitmaps 0

	item 54 key (FREE_SPACE UNTYPED 248936136704) itemoff 12849 itemsize 41

		location key (1371 INODE_ITEM 0)

		cache generation 120360 entries 412 bitmaps 2

	item 55 key (FREE_SPACE UNTYPED 249204572160) itemoff 12808 itemsize 41

		location key (1385 INODE_ITEM 0)

		cache generation 120196 entries 143 bitmaps 2

	item 56 key (FREE_SPACE UNTYPED 250278313984) itemoff 12767 itemsize 41

		location key (1390 INODE_ITEM 0)

		cache generation 120201 entries 48 bitmaps 0

	item 57 key (FREE_SPACE UNTYPED 251352055808) itemoff 12726 itemsize 41

		location key (1413 INODE_ITEM 0)

		cache generation 120197 entries 25 bitmaps 0

	item 58 key (FREE_SPACE UNTYPED 252425797632) itemoff 12685 itemsize 41

		location key (1414 INODE_ITEM 0)

		cache generation 120211 entries 345 bitmaps 7

	item 59 key (FREE_SPACE UNTYPED 254573281280) itemoff 12644 itemsize 41

		location key (1419 INODE_ITEM 0)

		cache generation 120316 entries 418 bitmaps 2

	item 60 key (FREE_SPACE UNTYPED 255649120256) itemoff 12603 itemsize 41

		location key (1514 INODE_ITEM 0)

		cache generation 120211 entries 788 bitmaps 2

	item 61 key (FREE_SPACE UNTYPED 256135659520) itemoff 12562 itemsize 41

		location key (1537 INODE_ITEM 0)

		cache generation 120232 entries 323 bitmaps 7

	item 62 key (FREE_SPACE UNTYPED 257209401344) itemoff 12521 itemsize 41

		location key (1544 INODE_ITEM 0)

		cache generation 120120 entries 239 bitmaps 2

	item 63 key (FREE_SPACE UNTYPED 258016804864) itemoff 12480 itemsize 41

		location key (1545 INODE_ITEM 0)

		cache generation 119883 entries 151 bitmaps 1

	item 64 key (FREE_SPACE UNTYPED 258285240320) itemoff 12439 itemsize 41

		location key (1546 INODE_ITEM 0)

		cache generation 120120 entries 299 bitmaps 2

	item 65 key (FREE_SPACE UNTYPED 258553675776) itemoff 12398 itemsize 41

		location key (1547 INODE_ITEM 0)

		cache generation 120211 entries 108 bitmaps 1

	item 66 key (FREE_SPACE UNTYPED 258822111232) itemoff 12357 itemsize 41

		location key (1548 INODE_ITEM 0)

		cache generation 120211 entries 22 bitmaps 0

	item 67 key (FREE_SPACE UNTYPED 259090546688) itemoff 12316 itemsize 41

		location key (1549 INODE_ITEM 0)

		cache generation 120211 entries 18 bitmaps 0

	item 68 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 11877 itemsize 439

		generation 87377 root_dirid 256 bytenr 5537579008 byte_limit 0 bytes_used 16384

		last_snapshot 64222 flags 0x0(none) refs 1

		drop_progress key (0 UNKNOWN.0 0) drop_level 0

		level 0 generation_v2 87377

		uuid 00000000-0000-0000-0000-000000000000

		parent_uuid 00000000-0000-0000-0000-000000000000

		received_uuid 00000000-0000-0000-0000-000000000000

		ctransid 0 otransid 0 stransid 0 rtransid 0

		ctime 0.0 (1970-01-01 00:00:00)

		otime 0.0 (1970-01-01 00:00:00)

		stime 0.0 (1970-01-01 00:00:00)

		rtime 0.0 (1970-01-01 00:00:00)
