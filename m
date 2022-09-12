Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24185B529D
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 03:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiILBws (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Sep 2022 21:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiILBwr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Sep 2022 21:52:47 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70078.outbound.protection.outlook.com [40.107.7.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAFB252A3
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Sep 2022 18:52:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXX4WIh7uxrjT9M5Bu85/NR0ie5JcHtr5QJRKLifzIMjrwF6tsm7lvfexVbe34uryoHPT7b4deyMAXB5R1ixNNDU0zYA5/7y/84JroaRd2zJ1e4MVyh7N0axD5cMHAzcUhNi5Oa6BxuDohZGOpW7D6W5mnFglxDQfNsXj4iXdAAP1/XCMt07xlYBFsYTV8JzXosnu1NzBOK6g0Z0hiFmPdC7l48B7O1TOKpKRsCddrErZ9P5FET1zyP+5Ge1fIsnOS/vHfcfSLCrE+gTN66IpRBiAE9oAXJ/+2F0ffDhB+bZ+lT557c8aTrHmYRcfrji9XcIFtd6CCJJtp6aGkQ0dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lrmA4jiJtBgDDN1Q/0IgUUQe9MIDJGI90LTzvYr9mg=;
 b=G674qMdyes4yc5yRHUJrh8ZfN3jX+m2pVFvyepchlE+Ey6whPwJLpyaymfCWpl3wXL4f7wfVhdwTukjAYIsw3NRrviojM9NpNNg2F+rekGCxmF2PS5lwB/ysjUOL4CGEYLU6kg+Rxdit5Io7f1n9GF5GJ7hYGTpZk7s78smz3aGuBV7/du/RX+4BDI2pLY8xlptfqy6YYhlRgoy4aFn33OWxZT4MLFHUn3LqNW2OPIZnJQ/06fTVA1+nRzCkP4JCCATL5ehaNydrP1zxXWGpdwcSnDV6x3oFyg6ZyySJWg5/X2blrIc+EoiCg4IDv0CtHsaQvv9hV31zjyawt7Bo3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lrmA4jiJtBgDDN1Q/0IgUUQe9MIDJGI90LTzvYr9mg=;
 b=UZFiRSOIAvh3rTs32kUYRsYycurR35dBu0NC2OBNkOc2i+fD0YyNXekNbFDD33icSYzIORi9w+ZhyKivCBY7s+ldW3Kll7GXRZdFNaGwYbJPmhmO23BBcvS/vpFRfH9LiUMG5DZdGAT6tq6qNKQWoRHbtarg+/4//ELfBnOntp32y5OKqeS3ZDWhuNYMfm3DCcDMouFD6DFR/iDr90TKiSAkgbFSd3REBTMU2BOAXW5KRJiqDwsij3WwMFY5tWILUYzl5gkf1pMnvhsFMA3MmscERnP6PTh1C3IxSOMYNXUEAfkQNi/jEd+hQLdHEvp8fuwLsHDYoDnggs4EvPQR+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DBBPR04MB7994.eurprd04.prod.outlook.com (2603:10a6:10:1ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 01:52:42 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::f9af:f33a:99ad:e10a]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::f9af:f33a:99ad:e10a%4]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 01:52:41 +0000
Message-ID: <c4ebb761-f60b-de1c-3e21-d4a1718f40e2@suse.com>
Date:   Mon, 12 Sep 2022 09:52:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: core dump in btrfs receive (while handling a clone command?)
Content-Language: en-US
To:     Antonio Muci <a.mux@inwind.it>, linux-btrfs@vger.kernel.org
References: <f3eee248-fd90-4048-8ae0-536997b4c273@inwind.it>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <f3eee248-fd90-4048-8ae0-536997b4c273@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::40) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DBBPR04MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: dedb94a4-e642-48da-0bc0-08da94617a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ud68zEEYh4Vs3aQjjk1xuo4c9NNzcNGyhQnN6NgOEgB3uDu+/LryMzpTXUsLNFuJY+VuZ5ppSgFASn0+u0TmgUXmRjKRgHc7L5bo6ml9C/q90H+4uU404FlxVPhAzSwSJUqazSeijuYWW4gDu8QXP8hJnrF9Bi6vomaGjaYd1pQRKONMc/fpK5vDC6ZsM0IdM89FhrhSyHHDenHFQPUz7hL7IQvYuAnPcIpxvO2sFZxhNOtac06h1hsFyjMIiRqXWWKbHrj152MGsjlfbKnt5nae6WyGGJXYBGSrUCBNWArTYq1nlISzD27rP/ki05+MoZyKifB5hsriVD1vBcpDlv6CcOYngsv9QJWJ53+8qXDjcRazeXjxh44aiMiwT7lMNid22uwl3U5hPPnSdtpwB+FLPh1/13347SFKW/kgyDqLKizuX7m1aFEwSi7KekW3SfSL+ezYEsl6RBf9ANYyirv2tCSl2+MUIkmrDv6oJiGMszQz92LPJUoUVA7kBzlq9dCKMP9PrJhyFtdvwCjyH6zqONiXd7qLdV890mHKwVoQR2yixXX2b1HMOX05y6pk7Hm4CbyQUTL6elQuW2tZjvCFHGxCoK+Mk1KX7iYL+bRKC+1jrNbAQz3J9LA5Z6hv2OmJBKu46wfq2LT8Jd7NitKMJWQroBJct6F6Qx08a691J9CudMogm89NsRi+nhgpKC3rh3bVTqpCcrHTrW59Yk15nm51OfPb5f9gX2L2m868JHIAFvoMlF4HAzbdDu4wvIZaefLbR9QpcKibK3LFBLjPzvOtxkqtd4meR67Q6VHC7J2zkwcrXuR4TFKJc7fjr9RCiO5r3l2pr4fdL4mEomyyMpfO/QsvACyZO//8tY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(366004)(136003)(396003)(6486002)(478600001)(6666004)(41300700001)(86362001)(966005)(31696002)(316002)(6512007)(6506007)(53546011)(186003)(36756003)(2616005)(83380400001)(38100700002)(5660300002)(8676002)(31686004)(8936002)(66946007)(66556008)(66476007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0prUTBJekFzaFhmYjZzeEVKTlZLYis1bTNid0JCdWtLTnRsU3lCdU16K0Yz?=
 =?utf-8?B?VWYrcHh5UjBaS29FQStnY0R4UTRMb2dnaXVWWjVyck0zSFdGM0hoOHk5NVE5?=
 =?utf-8?B?UXhQc2JBNE40ZmJLdHpsU1JEU0l1Ni9BY3NWVkEwVWNBZ0xldGQwRVNLbXh6?=
 =?utf-8?B?NjJ2QWcyRkEwRnJ5RTI0Snk3dE1kOERBTVlrNXFPN0R2d0kvS0FGeU9KaXNL?=
 =?utf-8?B?WDB2Wlc4RG9zNEVJTW84ZnRSb1dMVU1CcHhEeDRFdUJSeUNyR2xFTDBqdVAv?=
 =?utf-8?B?Z0NmaFpDVGNQMHBWR0IrM1JBMzI1ZlZqenhhUGowYUI4RzRkOFZPV09YWThI?=
 =?utf-8?B?QmZqOGJrK1VwdyttTm9haHZRamhaNmp4K2VFQkwxbXd6Zk1TRllNSll5cUow?=
 =?utf-8?B?RHNEdVFQMk55T2ZSblV6RXJQNVU3bDR5c2VwZWZXL1AzSmkrcVFKYThVOHJ6?=
 =?utf-8?B?TkMxRVhEZm9SZW42NXdlRW9TRW1Jalc5Ym1RS1BkbFM4eWVFeHgyaTk5aHBj?=
 =?utf-8?B?VXRBSUtURGE2bU1aczN0TkdyN1lTSzNqNE92bWlzdG9SYTNISkN1Tm85RDYr?=
 =?utf-8?B?bEZ1TXNMTHU3bWsvRDVGY2g2VlRmMzlxV1Mwb1V2YmFpSDRtZ2lvKzJ3QzV2?=
 =?utf-8?B?eGVaRi9NRWZ0TEtFK2cxYU0vRHlsV2paL2ZaOTBrOXh6aUVQVVRTS09mdWhP?=
 =?utf-8?B?dUNDNU15NmEwWGhVeFlrY1gyK1lRbnQ5d01DbmhRMHNhWUJhNU1xQVpMMVdB?=
 =?utf-8?B?OHJrekEvdkJMT2tRaXVuQ0tGNjVWS3BneUsreW02WlczVkkzRGgva1Rpc0VM?=
 =?utf-8?B?Ykl5T1h6RG1OdmNQVlJFbGRnMmw2dXhucFk0eEEzYUVkaTBjb2ZZYk5xVkti?=
 =?utf-8?B?Zndmck9JbVhjL09mUnlCM0FOaHIxV05hNHFyK0k2RGdCUU9Nc3hlZXhCa0s2?=
 =?utf-8?B?N2JreXZPMWt2VlZWTlZHaTJURVU1dWhOY2x2RlRvWDNpS2hHWjMyUEFaa1My?=
 =?utf-8?B?bzNCZjN4MkVxQ1ZMcU9CNlFsT0M3blJFamNaclQwTGkrRTJkcDdhNGFaNGt5?=
 =?utf-8?B?TXpkRjkraHVCNzZhTllENGM1dlRwbVYxMDgrTmowcjBZY0ttWDBjTnpTY1Y0?=
 =?utf-8?B?TDNEU1NmcEIwMHAvMXlycnhXVDNmYm9naS9lVzY2K1BlWXAyNFdRZWR6bnRX?=
 =?utf-8?B?MllqOXJWYURzMU93MWxtQTcwOVgwci9YR2UvQ1BLZENqc3ZmNk11ekthY0NK?=
 =?utf-8?B?cVpzbnR1Kzlmd1NSWXpuQzl3cWpheVRXTXQwdWlYbzUrRmZvNkptVlRCeEkw?=
 =?utf-8?B?WVhkMVR4UXFpbnZEVlhONlRWWE5JTG5HRU9RZEZ4M1l6ZXpMSnlzeWN0T0Rv?=
 =?utf-8?B?cEk5MXhZczF4cXJRd1BrZVhCbkFKZm11TVBkN2VnUVRmbXV4ZmVJeXFCOFVx?=
 =?utf-8?B?QnZNZkxPYWQrUmRZRlE4S0tRUXNGUFpIK0pnUHk2d3hnQzU1NEFDVGREU0xn?=
 =?utf-8?B?K2NkVjB3ZnBOcFEreDZwek1vdHk4TlhRSEk0YVlXYkZiWVdlNzN2cDJTTW9T?=
 =?utf-8?B?UEIxQlpYbVh3UTNtMFFib0dxblB6ZmZGOU5qNVl6TFRwbUcwYnJRbVBNRFBD?=
 =?utf-8?B?K0tjclFvd3NWRFlXTFR4Q1VBZm9HM09SSG0weG9xNHlFSWxDUnlNS1lMenVX?=
 =?utf-8?B?VUpJSlZQZ2FiaGNCUmhELzFLOHZZSFMwMTlEc0trSDdFMC9ENVZMWjA1Rzc5?=
 =?utf-8?B?VGFmSUtzeEtvbldFeTNLV2tuc1c1WUdEazF0S2FuNzBUZERVSUZlZy8zeGxJ?=
 =?utf-8?B?TGtPZUQwSUI5aDdQZ1pBcE0yRnFjU0JTWHNUNjJmVmNwQStpTXVaRjdtMlpC?=
 =?utf-8?B?U3ZQZUhvZkEvdm9ISVRRY2pMa0ZyV1hIYmVVaU1oUWZqS3ZMdlVzMkJvNlpS?=
 =?utf-8?B?OENmMG9sWWVPMWN1Sng3eFVISU8wVGRRYnFCdENWZlBqczdsSkFwYzNqODZs?=
 =?utf-8?B?cHV0Q3RCUE0rcmJLYy9WTzdoajVscFAyRU9LZUxZWFpLQ0RhMkxMYzZuWi84?=
 =?utf-8?B?eU9YN1hObWg1UFFnYmhVZ3FDQ2E4MVY2WkZUTUxMREZGR01TR0FJVExwMHdD?=
 =?utf-8?B?cFZKYzNXMCtXeGpUZVJuTCs1dHlHdzF1MlR4N3V4SWFZNlVNOXBhdVVXaWxC?=
 =?utf-8?Q?DUBcJUIvEOI/xUBRo5dexq0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedb94a4-e642-48da-0bc0-08da94617a89
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 01:52:41.5980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pewAovPkEDit1oEvTLJw0BUECesJMB0o3H/BmkH+ik51S4qplddBPfLrPdnSF7RM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7994
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/12 09:43, Antonio Muci wrote:
> Hi everyone,
> 
> I am experiencing a segmentation fault in "btrfs receive" and I would
> really appreciate any help the developers could give me.
> 
> The error happens when performing an incremental send from an external
> drive back to my main btrfs RAID-1 data store. Both the source and
> destination file systems contain the same base read-only snapshot.
> 
> The file that causes the problem is a bit "special": it is a sqlite3
> database which is written by a batch process. Before each run, I do a
> cp --reflink to a backup file, and then set the immutable flag on the
> reflinked copy. The source file is then modified by my batch process and
> eventually sent/received in snapshots that contain both the modified
> file and its reflinked copy. The source btrfs snapshot is not
> necessarily taken right after the cp --reflink / chattr +i.
> 
> Let's be general and say that the operation order is (fictional path
> names):
> 
> On the "main" datastore:
>    # cp --reflink /main/live/db.sqlite3 /main/live/db.backup
>    # chattr +i /main/live/db.backup
>    [do something to /main/live/db.sqlite3 modifying some parts of it]
>    # btrfs snapshot -r /main/live /main/backup-before
>    [this snapshot was sent to an external drive. Everything went ok, no 
> problems here]
> 
> On the "external" drive (omitting a snapshotting pass to make the
> /backup-before snapshot writable again):
> 
>    [do something to db.sqlite3 modifying some parts of it]
>    # btrfs snapshot -r /external/live /external/backup-after
> 
> The crash happens when trying to send an incremental stream from the
> external drive back to my main datastore (commands simplified once
> again):
> 
>    # btrfs send -p /external/backup-before /external/backup-after | 
> btrfs receive /main
>    At subvol /external/backup-after
>    Segmentation fault (core dumped)
> 
> I am on Fedora 36 with its current distro packages:
> kernel 5.19.8-200.fc36.x86_64, btrfs-progs v5.18.
> 
> This is the maximum level of detail I could achieve:
> 
> 
> 
> 
> # coredumpctl info
>             PID: 3152 (btrfs)
>             UID: 0 (root)
>             GID: 0 (root)
>          Signal: 11 (SEGV)
>       Timestamp: Mon 2022-09-12 02:21:52 CEST (29s ago)
>    Command Line: btrfs --verbose receive --max-errors 0 /main
>      Executable: /usr/sbin/btrfs
>   Control Group: 
> /user.slice/user-1000.slice/user@1000.service/app.slice/app-org.kde.konsole-3174091612104ca498465f6bcf3fb1ca.scope
>            Unit: user@1000.service
>       User Unit: app-org.kde.konsole-3174091612104ca498465f6bcf3fb1ca.scope
>           Slice: user-1000.slice
>       Owner UID: 1000 (ant)
>         Boot ID: 2799d9eb6dbd423aa57676cad3e64ee7
>      Machine ID: 21b44b8aef264e2181bdb4c7c9beca87
>        Hostname: cuben.lan
>         Storage: 
> /var/lib/systemd/coredump/core.btrfs.0.2799d9eb6dbd423aa57676cad3e64ee7.3152.1662942112000000.zst (present)
>       Disk Size: 58.2K
>         Message: Process 3152 (btrfs) of user 0 dumped core.
> 
>                  Module linux-vdso.so.1 with build-id 
> ef533bb262f1a045f813981c3d60075160f0756a
>                  Module libgcc_s.so.1 with build-id 
> ba60d61c81d3c90075c6a172f22972d643a41cc9
>                  Module ld-linux-x86-64.so.2 with build-id 
> 1eacb7c50f7ed20ef1fefda3aa9c67377686acf5
>                  Module libc.so.6 with build-id 
> 9c5863396a11aab52ae8918ae01a362cefa855fe
>                  Module libzstd.so.1 with build-id 
> e9ef04083d00304da3a4e6638d4d21cf65518077
>                  Metadata for module libzstd.so.1 owned by FDO found: {
>                          "type" : "rpm",
>                          "name" : "zstd",
>                          "version" : "1.5.2-2.fc36",
>                          "architecture" : "x86_64",
>                          "osCpe" : "cpe:/o:fedoraproject:fedora:36"
>                  }
> 
>                  Module liblzo2.so.2 with build-id 
> cfe9fae541ae0995689232b4bafe60ee4b99fd30
>                  Stack trace of thread 3152:
>                  #0  0x0000560c9a53ce91 process_clone (btrfs + 0x70e91)
>                  #1  0x0000560c9a51eb0c 
> btrfs_read_and_process_send_stream (btrfs + 0x52b0c)
>                  #2  0x0000560c9a53e0c9 cmd_receive.lto_priv.0 (btrfs + 
> 0x720c9)
>                  #3  0x0000560c9a4e3cae main (btrfs + 0x17cae)
>                  #4  0x00007f960a0df550 __libc_start_call_main 
> (libc.so.6 + 0x29550)
>                  #5  0x00007f960a0df609 __libc_start_main@@GLIBC_2.34 
> (libc.so.6 + 0x29609)
>                  #6  0x0000560c9a4e3ff5 _start (btrfs + 0x17ff5)
>                  ELF object binary architecture: AMD x86-64
> 
> 
> 
> # dmesg --human
> btrfs[3152]: segfault at 56 ip 0000560c9a53ce91 sp 00007ffdd23940a0 
> error 4 in btrfs[560c9a4e2000+9f000]
> Code: 31 c0 41 bc fe ff ff ff e8 7c aa fd ff e9 97 fe ff ff 0f 1f 80 00 
> 00 00 00 41 89 c4 48 8d 3d be a7 06 00 31 c0 e8 5f aa fd ff <49> 8b 7f 
> 58 e8 86 5f fa ff 4c 89 ff e8 7e 5f fa ff e9 69 fe ff ff
> 
> Installing debug symbols and looking at the backtrace it seems that the
> error is caused by a "free(si->path)" in cmds/receive.c:793 (I think
> this might be
> https://github.com/kdave/btrfs-progs/blob/v5.18.1/cmds/receive.c#L793):
> 
> 
> 
> # gdb btrfs 
> core.btrfs.0.2799d9eb6dbd423aa57676cad3e64ee7.3152.1662942112000000
> GNU gdb (GDB) Fedora 12.1-1.fc36
> [...]
> Core was generated by `btrfs --verbose receive --max-errors 0 /main'.
> Program terminated with signal SIGSEGV, Segmentation fault.
> #0  process_clone (path=0x560c9bd24a80 "db.sqlite3", offset=1045131264, 
> len=10760192, clone_uuid=<optimized out>, clone_ctransid=440,
>      clone_path=0x560c9bd24b40 "db.sqlite3", clone_offset=1045131264, 
> user=0x7ffdd23aa3f0) at cmds/receive.c:793
> 793                     free(si->path);
> (gdb) bt
> #0  process_clone (path=0x560c9bd24a80 "db.sqlite3", offset=1045131264, 
> len=10760192, clone_uuid=<optimized out>, clone_ctransid=440,
>      clone_path=0x560c9bd24b40 "db.sqlite3", clone_offset=1045131264, 
> user=0x7ffdd23aa3f0) at cmds/receive.c:793

This looks like a bug recently fixed by this patch:

https://patchwork.kernel.org/project/linux-btrfs/patch/20220902161327.45283-1-wangyugui@e16-tech.com/

Mind to test the latest devel branch which should already have it merged?

Thanks,
Qu

> #1  0x0000560c9a51eb0c in read_and_process_cmd (sctx=0x7ffdd2396200) at 
> common/send-stream.c:422
> #2  btrfs_read_and_process_send_stream (fd=<optimized out>, 
> ops=<optimized out>, user=<optimized out>, honor_end_cmd=<optimized 
> out>, max_errors=<optimized out>) at common/send-stream.c:525
> #3  0x0000560c9a53e0c9 in do_receive (max_errors=<optimized out>, 
> r_fd=0, realmnt=0x7ffdd23a63f0 "", tomnt=<optimized out>, 
> rctx=0x7ffdd23aa3f0) at cmds/receive.c:1111
> #4  cmd_receive (cmd=0x560c9a5c9c40 <cmd_struct_receive>, 
> argc=<optimized out>, argv=<optimized out>) at cmds/receive.c:1314
> #5  0x0000560c9a4e3cae in cmd_execute (argv=0x7ffdd23ad638, argc=4, 
> cmd=0x560c9a5c9c40 <cmd_struct_receive>) at cmds/commands.h:125
> #6  main (argc=4, argv=0x7ffdd23ad638) at 
> /usr/src/debug/btrfs-progs-5.18-1.fc36.x86_64/btrfs.c:405
> 
> 
> 
> 
> Having a look at the generated command stream, the crash appears to
> happen right after trying to precess the first "clone" command:
> 
> 
> # btrfs send -p /external/backup-before /external/backup-after | btrfs 
> receive --dump
> [a single snapshot command]
> [many utimes and write commands, but no clone]
> write ...
> write ./backup-after/db.sqlite3 offset=1041842176 len=4096
> clone ./backup-after/db.sqlite3 offset=1045131264 len=10760192 
> from=./backup-after/db.sqlite3 clone_offset=1045131264 <-- same offsets 
> as the core dump
> [other commands, but at this time btrfs receive has already crashed]
> 
> 
> However, I have no idea if this might be caused by some other problem
> somewhere else, like the reflinked copy plus its immutable flag? Who
> knows.
> 
> Many thanks for your help!
> Antonio
> 
