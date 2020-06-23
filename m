Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93888204631
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 02:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbgFWAvj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jun 2020 20:51:39 -0400
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:13572
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731698AbgFWAvg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jun 2020 20:51:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/QmgfizAXUJ2002wsJ93iJrjMBG+OYVT9SuVItENxzmKblOd4oqN5H+jzX0CJLYmJFPgybr2xOd1mCrXscwQzfwOXabxPB4MSlQm3tFMUiadm98jQnqEsM4gKBgVVhi6XaXuBtZGdDNiOGdV6V0klxQDR++o8KqQms55/N7bKi5SS9mNjZA+oBJ/ijcmJEXcnMaicwcLWvch41PREP5Uf0uFBXPQ7jR6lk+QdkMK+z1ii3jt1ad706LaSmM7NRjFZMvHAw3qhFwtjc3XVWhd2frg4XiEqcJREhwtQ1oau2ZPg4MMiVSDLZx45rjHT/k85yHurRgdfLiUq1aY1mxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7Ut3h0HZNThWls5j0P7OrfEgUcbpN+5i/QMX2BDx68=;
 b=RT3Lgu3vQKsPRBl3AmtcZ2dtvOo74Ngu5+tRWFSBqookm1/Jjj7tvGwHB8nLoHcPu2NIXjtTljGjZsVErHBQFliX7u9+0GDhsDB6JMBNrFQrhhSjt24lmJffv/xubkWsnbrFuYD0cv1P2csozVHUpirbb8v0CLG3x18YTCCQa868tlGwoxV6RQwaxT2jvDBkYG5GIYsvUNX9rJvu9uae4iRg8aNIT9PWBEg5dmviGxZDir0cy7zaK+91jpg6lxfHDQzR3DOl5cQ2TOPwHqWZ8PeSgam0vM12jyg2N+b5M2sDXA63SxpWpksmHPcCI73ARUrx4qP2PF+LDjEZhG0fZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7Ut3h0HZNThWls5j0P7OrfEgUcbpN+5i/QMX2BDx68=;
 b=R4OFAJeHTUtOFktfLs2LWN39N7bD1UBbdrVOBapIW+fMEgRtaen5FRSouJnYIRj83CkHO74tP4QOMgpJWpsMwSIS2fNhppxTaoDL556Yc1PHzwhZo1Ou5v94bSylMrxiBpj7kmCetphIKd2nzbOYOc6SVyOSLJGmoiso5YDxG9HsjLuNZwGYZ6bZhUM2J6psvm5S1Lc472wOadUg6UQ7WVdFU0b8S+goujO5tuy5vUCvw8PIsFLtD0EOkjB8DuDDrW2smbkWvOhnCJszJVqoeIzXzIqaWvIlEphDCbuGgvbVQtB7cz0NevnzFg7kLOVXbz/TV+nk5w6Qqjq7MilD8A==
Authentication-Results: nic.cz; dkim=none (message not signed)
 header.d=none;nic.cz; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB6178.eurprd04.prod.outlook.com (2603:10a6:208:146::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 00:51:31 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::3457:290d:6345:6961]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::3457:290d:6345:6961%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 00:51:31 +0000
Subject: Re: [PATCH U-BOOT v2 00/30] fs: btrfs: Re-implement btrfs support
 using the more widely used extent buffer base code
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
References: <20200525063257.46757-1-wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <b53fe949-204a-1141-2da0-0f72e60a19dc@suse.com>
Date:   Tue, 23 Jun 2020 08:50:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200525063257.46757-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0026.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::39) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR20CA0026.namprd20.prod.outlook.com (2603:10b6:a03:1f4::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 00:51:29 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab135987-c01e-4bad-a3ef-08d8170f91fd
X-MS-TrafficTypeDiagnostic: AM0PR04MB6178:
X-Microsoft-Antispam-PRVS: <AM0PR04MB6178531B771A37E8F2F186ECD6940@AM0PR04MB6178.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYfRLZv5P65V/wSLpxZLnAkTymqDkv70TvEmIBTRJXk3gcNC0lErAzCPWqOAf1vAmozPWUemw9kFE2Afytnz+9sL6RNE2p3cHpYPWpq3t8hIPXXy0HCNCyCFVateYmaIqU9jlkWPHVAmJE6Wk/iht5w3aI7IPw7KNjMkbYqLNkGHQ8UngCVH+nBAFrD0TI6mx9fg9n0C+M7oZWOT/9d5gXXjOC+DYhyPidihY9W/r0FsUGeZVczgWZ5A8Ptx//4KUd/sKrjg/7b6qDZr2kn0kbweVzi1osChkGqQSNirb4wGgCM8IQ1cj8UR6Cc5HTDI5IAnCYNcL0ugRgMv1+uNaMeGW/m+yinsVzoyvY+RSehUXd1BLfi6Es63ZdUXVAk1A34iIVNsH2+zSzdI7ej/+Dpu9Hhbw3OtwZ4KFv5wd2JMRKkvhWDVM14n6hF7/i6dLBdYXCCEzEGJ4b7P9xl9NamOdys1PqVkorxYDgKExgtbdNhAZ3gUD5QRyZkFG3DKf4hp14lsPob3HC87mGK7eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(376002)(396003)(136003)(346002)(16526019)(186003)(2906002)(316002)(966005)(16576012)(26005)(6666004)(5660300002)(31686004)(8676002)(52116002)(6706004)(6486002)(86362001)(956004)(2616005)(36756003)(8936002)(83380400001)(66476007)(66556008)(31696002)(478600001)(4326008)(66946007)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eZbNokCbpvc3mHLE2XgR7djmwjR7YLK1S+9MG2BM0HEOSEazu+eg8iZysV9PvVhRAqldAOH1a9F9U7O3xXZ4j0JHM215l2lQqg/NjzigRiecGVe/bRiQE9xrtwcu2UPydDQFwytT5KzZkUoXodEKfWyw/C5oT9iy+3II+2/vAzLQhO9GU5BSEasyQw/is+DSfNe3goheEsvdpXXCDaqv7n0aOo7b5NlBQJ5cqnG/TunjXY1kVGoIEvQQKEqvAGIJrg2+Hd6d7np4M18yAzRaDcWz+9K5aKA9nnnzMx4EY1qvVVrd/6AZd5uuAO+Urgu+dISWbVN1Son4LittXVF3IjZkoAuRgOZbWLUy7xHXTO8uzm/0mppxe5QfJ1lp4t8byWubjR3cFp9MwlWf9kRPFjdjS9O2z9zpmAF2dzc+P2LiF1HSwukHVLCTLhHDrVM4dGg2inWHW3mOePsrWvFyg7r0B+sZ64Dj0H2u+sDeng0=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab135987-c01e-4bad-a3ef-08d8170f91fd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 00:51:31.6051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9+tFbuGsAriSXRDvxcIRK6otbLsUR2MPlwiOFWz1B5sT5053etvuHP39HKkdvDe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6178
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Gentle ping?

Any updates?
Hopes this won't block the incoming new features too long.

Thanks,
Qu

On 2020/5/25 下午2:32, Qu Wenruo wrote:
> The branch can be fetched from github:
> https://github.com/adam900710/u-boot/tree/btrfs_rebuild
> 
> The current btrfs code in U-boot is using a creative way to read on-disk
> data.
> It's pretty simple, involving the least amount of code, but pretty
> different from btrfs-progs nor kernel, making it pretty hard to sync
> code between different projects.
> 
> This big patchset will rework the btrfs support, to use code mostly from
> btrfs-progs, thus all existing btrfs developers will feel at home.
> 
> During the rework, the following new features are added:
> - More hash algorithm support
>   SHA256 and XXHASH support are added.
>   BLAKE2 needs more backport, will happen in a separate patchset.
> 
> - The ability to read degraded RAID1
>   Although we still only support one device btrfs, the new code base
>   can choose from different copies already.
>   As long as new device scan interface is provided, multi-device support
>   is pretty simple.
> 
> - More correct handling of compressed extents with offset
>   For compressed extent with offset, we should read the whole compressed
>   extent, decompress them, then copy the referred part.
> 
> There are some more features incoming, with the new code base it would
> be much easier to implement:
> - Data checksum support
>   The check would happen in read_extent_data(), btrfs-progs has the
>   needed facility to locate data csum.
> 
> - BLAKE2 support
>   Need BLAKE2 library cross ported.
>   For btrfs it's just several lines of modification.
> 
> - Multi-device support along wit degraded RAID support
>   We only need an interface to scan one device without opening it.
>   The infrastructure is already provided in this patchset.
> 
> These new features would be submitted after the patchset get merged,
> since the patchset is already large, I don't want to make it more scary.
> 
> Although this patchset look horribly large, most of them are code copy
> from btrfs-progs.
> E.g extent-cache.[ch], rbtree-utils.[ch], btrfs_btree.h.
> And ctree.h has over 1000 lines copied just for various accessors.
> 
> While for disk-io.[ch] and volumes-io.[ch], they have some small
> modifications to adapt the interface of U-boot.
> E.g. btrfs_device::fd is replace with blkdev_desc and disk_partition_t.
> 
> The new code for U-boot are related to the following functions:
> - btrfs_readlink()
> - btrfs_lookup_path()
> - btrfs_read_extent_inline()
> - btrfs_read_extent_reg()
> - lookup_data_extent()
> - btrfs_file_read()
> - btrfs_list_subvols()
> 
> Thus only the following 5 patches need extra review attention:
> - Patch 0017
> - Patch 0019
> - Patch 0023
> - Patch 0024
> - Patch 0025~0028
> 
> Changelog:
> v2:
> - Implement btrfs_list_subvols()
>   In v1 it's completely removed thus would cause problem if btrfsolume
>   command is compiled in.
> 
> - Rebased to latest master
>   Only minor conflicts due to header changes.
> 
> - Allow next_legnth() to return value > BTRFS_NAME_LEN
> 
> Qu Wenruo (30):
>   fs: btrfs: Sync btrfs_btree.h from kernel
>   fs: btrfs: Add More checksum algorithm support to btrfs
>   fs: btrfs: Cross-port btrfs_read_dev_super() from btrfs-progs
>   fs: btrfs: Cross-port rbtree-utils from btrfs-progs
>   fs: btrfs: Cross-port extent-cache.[ch] from btrfs-progs
>   fs: btrfs: Cross-port extent-io.[ch] from btrfs-progs
>   fs: btrfs: Cross port structure accessor into ctree.h
>   fs: btrfs: Cross port volumes.[ch] from btrfs-progs
>   fs: btrfs: Crossport read_tree_block() from btrfs-progs
>   fs: btrfs: Rename struct btrfs_path to struct __btrfs_path
>   fs: btrfs: Rename btrfs_root to __btrfs_root
>   fs: btrfs: Cross port struct btrfs_root to ctree.h
>   fs: btrfs: Crossport btrfs_search_slot() from btrfs-progs
>   fs: btrfs: Crossport btrfs_read_sys_array() and
>     btrfs_read_chunk_tree()
>   fs: btrfs: Crossport open_ctree_fs_info()
>   fs: btrfs: Rename path resolve related functions to avoid name
>     conflicts
>   fs: btrfs: Use btrfs_readlink() to implement __btrfs_readlink()
>   fs: btrfs: inode: Allow next_length() to return value > BTRFS_NAME_LEN
>   fs: btrfs: Implement btrfs_lookup_path()
>   fs: btrfs: Use btrfs_iter_dir() to replace btrfs_readdir()
>   fs: btrfs: Use btrfs_lookup_path() to implement btrfs_exists() and
>     btrfs_size()
>   fs: btrfs: Rename btrfs_file_read() and its callees to avoid name
>     conflicts
>   fs: btrfs: Introduce btrfs_read_extent_inline() and
>     btrfs_read_extent_reg()
>   fs: btrfs: Introduce lookup_data_extent() for later use
>   fs: btrfs: Implement btrfs_file_read()
>   fs: btrfs: Introduce function to reolve path in one subvolume
>   fs: btrfs: Introduce function to resolve the path of one subvolume
>   fs: btrfs: Imeplement btrfs_list_subvols() using new infrastructure
>   fs: btrfs: Cleanup the old implementation
>   MAINTAINERS: Add btrfs mail list
> 
>  MAINTAINERS                         |    1 +
>  fs/btrfs/Makefile                   |    5 +-
>  fs/btrfs/btrfs.c                    |  319 +++---
>  fs/btrfs/btrfs.h                    |   67 +-
>  fs/btrfs/btrfs_tree.h               |  766 --------------
>  fs/btrfs/chunk-map.c                |  178 ----
>  fs/btrfs/common/rbtree-utils.c      |   83 ++
>  fs/btrfs/common/rbtree-utils.h      |   53 +
>  fs/btrfs/compat.h                   |   88 ++
>  fs/btrfs/compression.c              |    2 +-
>  fs/btrfs/crypto/hash.c              |   55 +
>  fs/btrfs/crypto/hash.h              |   17 +
>  fs/btrfs/ctree.c                    |  866 ++++++++++++----
>  fs/btrfs/ctree.h                    | 1453 ++++++++++++++++++++++-----
>  fs/btrfs/dir-item.c                 |  192 ++--
>  fs/btrfs/disk-io.c                  | 1063 ++++++++++++++++++++
>  fs/btrfs/disk-io.h                  |   50 +
>  fs/btrfs/extent-cache.c             |  318 ++++++
>  fs/btrfs/extent-cache.h             |  104 ++
>  fs/btrfs/extent-io.c                |  848 ++++++++++++++--
>  fs/btrfs/extent-io.h                |  164 +++
>  fs/btrfs/hash.c                     |   38 -
>  fs/btrfs/inode.c                    |  892 +++++++++++-----
>  fs/btrfs/kernel-shared/btrfs_tree.h | 1333 ++++++++++++++++++++++++
>  fs/btrfs/root-tree.c                |   47 +
>  fs/btrfs/root.c                     |   92 --
>  fs/btrfs/subvolume.c                |  310 ++++--
>  fs/btrfs/super.c                    |  257 -----
>  fs/btrfs/volumes.c                  | 1173 +++++++++++++++++++++
>  fs/btrfs/volumes.h                  |  204 ++++
>  30 files changed, 8537 insertions(+), 2501 deletions(-)
>  delete mode 100644 fs/btrfs/btrfs_tree.h
>  delete mode 100644 fs/btrfs/chunk-map.c
>  create mode 100644 fs/btrfs/common/rbtree-utils.c
>  create mode 100644 fs/btrfs/common/rbtree-utils.h
>  create mode 100644 fs/btrfs/compat.h
>  create mode 100644 fs/btrfs/crypto/hash.c
>  create mode 100644 fs/btrfs/crypto/hash.h
>  create mode 100644 fs/btrfs/disk-io.c
>  create mode 100644 fs/btrfs/disk-io.h
>  create mode 100644 fs/btrfs/extent-cache.c
>  create mode 100644 fs/btrfs/extent-cache.h
>  create mode 100644 fs/btrfs/extent-io.h
>  delete mode 100644 fs/btrfs/hash.c
>  create mode 100644 fs/btrfs/kernel-shared/btrfs_tree.h
>  create mode 100644 fs/btrfs/root-tree.c
>  delete mode 100644 fs/btrfs/root.c
>  delete mode 100644 fs/btrfs/super.c
>  create mode 100644 fs/btrfs/volumes.c
>  create mode 100644 fs/btrfs/volumes.h
> 
