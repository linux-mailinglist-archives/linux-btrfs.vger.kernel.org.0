Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C8F608FAB
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Oct 2022 23:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJVVNL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Oct 2022 17:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJVVNJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Oct 2022 17:13:09 -0400
Received: from fallback19.mail.ru (fallback19.mail.ru [185.5.136.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0487580533
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Oct 2022 14:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Bbo2+0ZGQxonbvzcgiYfSQNuMP17/fcdVM+IA4OQ2qI=;
        t=1666473187;x=1666563187; 
        b=EaVyv8Tn+T89zKx6dzK9cm0uaDWrlAfMmUgKdx8ElkIOAKfqm9EzGZNKV2TOPTYauAAmAcsn4JbZJdFQ5All7/3zSYAwh/OeSzajs3x625EW5tni07+UDFnyFOd9IEjZ2wLdeudVxbvVj1OkDAKpOYl8ZHs9UNTR9jDdYGXEbmAbqiw2YXyq+a15/wy1Jzg3j1CDw4IS6c7XqSN0ebbIl6q2/GBVwHFMRdW3FTjQ+m+3XyM03upnjlE8nNXfe2jEIF1guhCXu02K3X6WziBrfE8b+UdgmqZ11t0WIF5pePlRg2GKvtxCJAFwA+x7oGGOFvFk5s3LZbWicC8p/G7gVg==;
Received: from [10.12.4.3] (port=50496 helo=smtp17.i.mail.ru)
        by fallback19.m.smailru.net with esmtp (envelope-from <Nemcev_Aleksey@inbox.ru>)
        id 1omLnk-0003bZ-6b
        for linux-btrfs@vger.kernel.org; Sun, 23 Oct 2022 00:13:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Bbo2+0ZGQxonbvzcgiYfSQNuMP17/fcdVM+IA4OQ2qI=;
        t=1666473184;x=1666563184; 
        b=dPvoh5C1sUH4+8HD/Db98u9MDB4uabMdXvWn/0XIZHVYjqTGM/lkxqARqNL9jGPojIIp3tyNvDydJXar17Wjzw8iqZ2CZu0M4645Nl6bD2iz/hRp161ncOgxiq61f8W6RscOtbbm7YPNjtIQ6g/FpbwnRsNknDUZULlV3wdK1IzgIGtDU3/vQlvkU/6fljyliwPLZ9ciYRmo7LwTHURayhaKrJv2Gy9ry5AvxeOsMCKWARI85z2UFUv/ZEIa/l2Rs2o6nydeI+Cds6LWpIMVQAfVshZsk7D5//kATJ+H76iWDmFPyCgK5z4+3DHxrzwv3HpXvmF5DqhIi7AMwkrHrA==;
Received: by smtp17.i.mail.ru with esmtpa (envelope-from <Nemcev_Aleksey@inbox.ru>)
        id 1omLng-003dUq-Sp
        for linux-btrfs@vger.kernel.org; Sun, 23 Oct 2022 00:13:01 +0300
Message-ID: <d87ce800-670e-9ca2-b524-8b20678abd9b@inbox.ru>
Date:   Sun, 23 Oct 2022 00:13:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
To:     linux-btrfs@vger.kernel.org
Content-Language: en-US
From:   Nemcev Aleksey <Nemcev_Aleksey@inbox.ru>
Subject: Is it safe to use snapshot without data as 'btrfs send' parent?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD97F9382DBE4976309FB4D10F4215E2EB8F6C6D2D174E2F270182A05F538085040D186DB467FE8989CD65EB2834C09777972EE2E40B75D9137A6B7DB274917A0AF
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7624C4D757C4F5837EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006372E9841F416E2DCCD8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8B42DCB8819C5B23DD0B12B822D3317F26F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE791DAD9F922AA71188941B15DA834481FA18204E546F3947C24A072987C00FFB1F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006375D86F985788DC295389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637B0942928F7682249D81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636D81D268191BDAD3D78DA827A17800CE7BDBD0A22A478E224EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5278DA827A17800CE7A03E8F3C2D3812562EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7B47F2F09EE599CE4731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A551149B8BB913E28E9827C385D16387CA57FC6A4C50A67F224EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34BD150993ED26DDF4B6C3480E7CF50FE7526AAC188A8502F97BABEB0CFBC89A216364268D203DADBD1D7E09C32AA3244C07C583430564B383D96DEC8CC64C87648894E9C85370243E3EB3F6AD6EA9203E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXj+kBvrhfAFRAxRrL8W8WSZ
X-Mailru-Sender: 00097D31F91C944B825D48F09EF66297A550E3F91C704A7785CFF5C52E5E943BF2ED597058F721A134915EAF49CC4078BE96CC90913223B28141B1B0B1FAE8F2B1D210AF280BDE3A90E1A63FA06EF59E02DB81B281332CC10D4ABDE8C577C2ED
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B41D0D107CA78B22788DADC62E504B0F5DE3F438ACE65591D9049FFFDB7839CE9E1EDFD276309BA9D8DCC3E35181D40CE9C1ECF37CDA78C78BC5E0E87FBB1FBE14
X-7FA49CB5: 0D63561A33F958A55E4D039497780E7C7591B3EFE6170725DCCD59224EA3BDE3CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F7900637AF8DFA94C5B6F7D6389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC81CF6DFABFD638A7DF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C0085B890FD2717DA302FCEF25BFAB3454AD6D5ED66289B52698AB9A7B718F8C442539A7722CA490CD5E8D9A59859A8B656ADF5DA62E5A3E1089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojsTZ3C30vYKqrEE2+7gPztQ==
X-Mailru-MI: 800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Btrfs developers.

Thank you for your great product, Btrfs!

I want to use Btrfs snapshots and 'btrfs send | btrfs receive' features 
to incremental backup my PC to an external drive.
I can do this using commands:
btrfs subvolume snapshot -r subvolume snapshot; btrfs send snapshot -p 
previous_snapshot | btrfs receive backup_drive

But Btrfs snapshots on my PC consume space even for deleted files.
So I can't just remove unused files to free space on my PC if I keep 
parent snapshots for incremental backups on this PC).
I need to do another backup, then remove snapshot left from previous 
backup from my PC to free up space.

I want to use metadata-only snapshots to overcome this issue.

Can I safely use the following chain of commands to keep metadata-only 
snapshot on my PC and keep full snapshots on the
backup drive?

# Initial full backup:
# Create temporary snapshot
btrfs subvolume snapshot -r source/@ source/@_backup
# Send temporary snapshot to the backup drive
btrfs send source/@_backup | btrfs receive backup_drive
# Delete temporary snapshot
btrfs subvolume delete source/@_backup
# Move received on backup drive snapshot to its final name
mv backup_drive/@_backup backup_drive/@_backup1
# Send back metadata-only snapshot to source FS
btrfs send --no-data backup_drive/@_backup1 | btrfs receive 
source/skinny_snapshots

# Incremental backups:
# Create temporary snapshot
btrfs subvolume snapshot -r source/@ source/@_backup
# Send temporary snapshot to the backup drive using metadata-only 
snapshot as parent
btrfs send source/@_backup -p source/skinny_snapshots/@_backup1 | btrfs 
receive backup_drive
# Delete temporary snapshot
btrfs subvolume delete source/@_backup
# Move received on backup drive snapshot to its final name
mv backup_drive/@_backup backup_drive/@_backup2
# Send back metadata-only snapshot to source FS
btrfs send --no-data backup_drive/@_backup2 -p backup_drive/@_backup1 | 
btrfs receive source/skinny_snapshots

I tested this sequence, and it seems to work fine on small test filesystems.
Backups seem to be correct and seem to have all files they should have 
with correct checksums after all.
Source FS frees up space after deleting files while having metadata-only 
snapshots on it.
It's possible to use such "skinny" snapshots as parent for btrfs send 
command.

But I'd like to get confirmation from Btrfs developers:
Is this approach safe?
Can I use it daily and be sure my backups will be consistent?

Thank you.
