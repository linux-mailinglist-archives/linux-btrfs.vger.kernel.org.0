Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E0C2C2C36
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Nov 2020 17:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389932AbgKXQDX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Nov 2020 11:03:23 -0500
Received: from mail-bn8nam08on2050.outbound.protection.outlook.com ([40.107.100.50]:34401
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388568AbgKXQDX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Nov 2020 11:03:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKrUgBaOKVXx0nCiuHic9QTh0Zw8grzKVuivS/W96HYqebCXpRWcxZNW20T4p7NsSYVb0aYOvkFa8b0vHztOqoqtyMOAFGss/+qnR0KvPFEFffIpeB0lpKyLy8kIqw32w3Eu1XprmU4XmOfWdgq+P4AYpYssIgqkJN2XHzVu/dPSAq0zInJfz694z8hAMDkhajoSwbozzaHGeQYJ2mQ+IJk4hxXk7YYgsmotIG2xugsL9+wXoZ6lIBEhTImVfyCQOI2lP8aYmOO9UDhbZm8CoZMdDF9YEOhfNt0yP1MTxJxQyT/PRMyhvdw6Ud1jICkFaRNK2SsW9xsp4fKPnONx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypUQVA84m4gTJW27GBTuxeX5EQq1FARcxR1hbNHyryI=;
 b=oVuQGqITqbPoJKKYVdokomC3iZhqZCh75NdX9boy+IEvak+TuV2pr3skMTJGW9aBExM0MNA0AUpSBhsX0e2vnrW6RRsZjOpWc3MQEs+79MwMOpg2J6/CMLBjZ9V6rYX3/1cMbYX72/jIRjuoYPNlZ97vGTDy5lea4Ouek5z9P4U/IQi0d6pfMmcTLbujvLsXmOrhHAdbcFTwV13T2Q2a6okeb9W083/uITWjRkwvaplxlvBjTkm58R1tvJ0NzAtqD40JzkvdAjOxbodXaFwhuIZiejdg3FfiIxWr8UPT7l+XvxxhU4x9gpFgLS8oW2iNElVT+JdhJXkjV310xO3edg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=panasas.com; dmarc=pass action=none header.from=panasas.com;
 dkim=pass header.d=panasas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=panasas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypUQVA84m4gTJW27GBTuxeX5EQq1FARcxR1hbNHyryI=;
 b=CxrvjEXqQNRIFOPvi8eth6DtChrIuX2FlNkZO4AZwtrpeSjWT85sG6lQLhYzsTZvgftcigq0bhKw2xkC3+RDiwMBmikJcVGXA5kfrf4+YYhX9uDUAiz5sqVIWFKYqb6Wc+i4r8C1fiKtf2dYdtfGS4Cgtw6R7OQqgQ4zj8E9I34=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=panasas.com;
Received: from BYAPR08MB5109.namprd08.prod.outlook.com (2603:10b6:a03:67::33)
 by SJ0PR08MB6510.namprd08.prod.outlook.com (2603:10b6:a03:2de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Tue, 24 Nov
 2020 16:03:19 +0000
Received: from BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::f8b4:660c:838c:7040]) by BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::f8b4:660c:838c:7040%7]) with mapi id 15.20.3589.022; Tue, 24 Nov 2020
 16:03:18 +0000
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   "Ellis H. Wilson III" <ellisw@panasas.com>
Subject: Snapshots, Dirty Data, and Power Failure
Message-ID: <b58c6024-1692-7e43-c0a5-182b1fae1cca@panasas.com>
Date:   Tue, 24 Nov 2020 11:03:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [96.236.219.216]
X-ClientProxiedBy: MN2PR19CA0056.namprd19.prod.outlook.com
 (2603:10b6:208:19b::33) To BYAPR08MB5109.namprd08.prod.outlook.com
 (2603:10b6:a03:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.2] (96.236.219.216) by MN2PR19CA0056.namprd19.prod.outlook.com (2603:10b6:208:19b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Tue, 24 Nov 2020 16:03:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b006d22-f356-493f-038f-08d890927592
X-MS-TrafficTypeDiagnostic: SJ0PR08MB6510:
X-Microsoft-Antispam-PRVS: <SJ0PR08MB6510C616CF6A4634C639F073C2FB0@SJ0PR08MB6510.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5g5vrTs8b1nV7FYnxLIDjQQTjvp/AgmUH3U1ozDOo4LsKI8YOW+M00hGr2BSVB5/kxvCEwEgnkyAB+k4N6l5XZmD8o2rApFSv7eZx2C+tVE07JSuI2OxYiLDCTRxG7AGs7iPEt5w5bqImOvnsdVcq4LblUecegXu/dzWKuREDKol2BJEOiurbrvPahD06AfiHGlkxV0KfpzdZeIAl7LM0eye+AWkljsv3V/zaMbhiDkss7McwfjUm3mn5kte8Z0iEfgyxLYJYtsCKKnM6QVYETVswx+ZqjAhiLXfMcT+aG5OJDPZX/b7Bg9+yMNXNG98tQVB6Hc+zEur1hiaEe3iFPHz4JIRjUpEPrLfaXfZnVJtWD/2nEWaQxLX703iTxCqRZUCScrl3Kc04rHq4EhDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR08MB5109.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(346002)(136003)(39840400004)(66556008)(8676002)(66476007)(8936002)(6666004)(83380400001)(86362001)(31686004)(6486002)(36756003)(31696002)(478600001)(5660300002)(52116002)(66946007)(16576012)(186003)(2906002)(6916009)(956004)(316002)(26005)(16526019)(2616005)(14143004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: i0mGU2O3Bed5wUQ1iZrDpp3/Yj/uXqInksxNI6RxJynPI0DFlo5T6aEqotr4go1fG9lcXlSBD7G/O8+J46RL89YD2li+5jlPD67DC+bBml8cb7CcVpBPFvbuHUXE8NUe3+MZj6sZp4CMWugcxlgxe9uLlbUsGsSxr5yni2AxdxI29jvg2xQWl0mEcSMSp+9fWTLZWpn5t0Y7TKcCEEG++3pEoRqSRECd4SFQJbt/uskqH5ATd9agZaQ2yOkmR4dY2zkIP0OBE75jo/17P8pczbixYNcbPEp5oyftl2bHsenF6sVJ3kplNsq02+glZ/o6eQJaGxCEIPWd9YDd99Z0Wi2DyKqbnHx96AlLpJfC/rxHnQ3mApCFbbvHJ+qGn9GJE/NGfzmyFa15xtC1nk7R5mmjtL6ZoQEuSMgmbJLA43/TnxFZMbI4wu+ieWFb/rz+ER6G/+38R0aZ0Wy2Ovcv2jJgcsz2sKxqSrHqarxfnchmFTXlKXKSkX09woRD0gQ9OQBk7JAmXMsz1JW2b26O7U3AHRHu6uK6DfaBg0u8hAKPwvdMGYRGTkbhudAEkGMz+2yogZGtQuq0WCbr1rinZG6tabTWyUvrsOqVQGxOh+FNjFBjh2ZU8ON9MP/s83Wt7Qy/O4tjbR5ArPQ2x13Z5vjGxm9Z65E/tSur1N2GzCZ5p8wXatDTKuJaRJYQQ4XhkSzJdeH/6+d0DTRj+O9ZA66LYBpJiN91PULo9MGVnTN1OZRcr5hiOdYrjr3jwfcf7bYgwwbOGFv2p0jEFycao4FLKb8zKW2o0sEYAGy8VwHYeBw/qX88fk/WjeopnybGq36Su8w3unerEqgQnbcQn+5SElcwgDOYgsMlOkCDwDhOryz9lwkHcHI879GnD6G2xWrJndGJHsLr45IBzps0Gw==
X-OriginatorOrg: panasas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b006d22-f356-493f-038f-08d890927592
X-MS-Exchange-CrossTenant-AuthSource: BYAPR08MB5109.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 16:03:18.7072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: acf01c9d-c699-42af-bdbb-44bf582e60b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMGb91MA5BBQ/uXpM6fm5rHE+EyAH7V85j32k48mUajvU1ae0ut8yQo1jlWaMdwr7YlmdUY2Ht3DiD/H5a/Rbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB6510
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

Back with more esoteric questions.  We find that snapshots on an idle 
BTRFS subvolume are extremely fast, but if there is plenty of data 
in-flight (i.e., in the buffer cache and not yet sync'd down) it can 
take dozens of seconds to a minute or so for the snapshot to return 
successfully.

I presume this delay is for the data that was accepted but not yet 
sync'd to disk to get flushed out prior to taking the snapshot. 
However, I don't have details to answer the following questions aside 
from spending a long time in the code:

1. Is my presumption just incorrect and there is some other 
time-consuming mechanics taking place during a snapshot that would cause 
these longer times for it to return successfully?

2. If I snapshot subvol A and it has dirty data outstanding, what power 
failure guarantees do I have after the snapshot completes?  Is 
everything that was written to subvol A prior to the snapshot guaranteed 
to be safely on-disk following the successful snapshot?

3. If I snapshot subvol A, and unrelated subvol B has dirty data 
outstanding in the buffer cache, does the snapshot of A first flush out 
the dirty data to subvol B prior to taking the snapshot?  In other 
words, does a snapshot of a BTRFS subvolume require all dirty data for 
all other subvolumes in the filesystem to be sync'd, and if so, is all 
previously written data (even to subvol B) power-fail protected 
following the successful snapshot completion of A?

4. Is there any way to efficiently take a snapshot of a bunch of 
subvolumes at once?  If the answer to #2 is that all dirty data is 
sync'd for all subvolumes for a snapshot of any subvolume, we're liable 
to have significantly less to do on the consecutive subvolumes that are 
getting snapshotted right afterwards, but I believe these still imply a 
BTRFS root commit, and as such can be expensive in terms of disk I/O (at 
least linear with the number of 'simultaneous' snapshots).

Thanks as always,

ellis
