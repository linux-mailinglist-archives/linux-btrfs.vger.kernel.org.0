Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE124007ED
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Sep 2021 00:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhICWfZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 18:35:25 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:50443 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232112AbhICWfY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Sep 2021 18:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1630708462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ohOhq3TjzHu9xjU3CHB528snZA8gPnybFvslakx1Cfw=;
        b=beIbYh6LyII+DYfUSCYq6wPdwvXX2BiOCm1wdtrMDGIs6anILgy71QXZWysiupRxm8h3zz
        SMWl0uJmo7oL2ZrUOlOoZhIZBGDAYZAJU/aeTu7ir2psXtcWzWJIcPTVvnwRdGc24fUdSM
        V5cuDUyO6MA4kDVvEUNs+2hS10LVezc=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2056.outbound.protection.outlook.com [104.47.0.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-22-63jpqo00OhKM1rherPQhJw-1; Sat, 04 Sep 2021 00:34:21 +0200
X-MC-Unique: 63jpqo00OhKM1rherPQhJw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2TLZZwXingyyKsJtd7SDOlYEt4LjiYNvjeW9cJ+ZaPtqMbPGzVRZK8DEthXoIoLIFAjSq8YwO1gTk8Q8nZuqWEmprJtSAGop09lpDYNRN/G+7yD/qpePkZwdZHxYQu+q6Pje47c/VqO+fXkZ+u4Jh37WiOWflh6Uabc8nxEU4OIuDDZh569NScGRRRZkNBN9O90JMdRkDPd7yoQT+bi6iKbaoPQu8nwusdXgF1NVsGqrTKjcLSLlH3Z2pKdsZWxNs++3kGFy575eHFfuIA7ibQ/izpMWDahn4F0Bedznp6pvH5WrsEjja8vj1qtGHIVpyaXLOT1OnIxGZwEDmON7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=asKplwQYvmxK8GI/tXfWwTJLmZuAVEjVvqZgNPPTcbQ=;
 b=hil1UqCMT4OIdC9BluHXFFrtjrGouktK0jf2phHoPIf+WMPNODzmlZHV1B9IzJ2TGkjjOHBEe+ILaRENiaIxasfj1acuVKdlTRms5nMXdIvn6/1xj0t7EZ/rkqm+sgIW8UDgVxQe6RprWhTEnjb34nb1d+t9vOW8pFVM1tcT25Ny8PnBQamwkEP6d2xf5UI6wVyQUuzcNC73gXQY5horr1WLwEy7nGCs/3nn4OD36iYf26ZfOZ2Pevno1GfUlyosfocRUHuOK8PBZ3K8s/+r7TSJlAlq3+eNejax0X291x7BRfO4OG+qDUOZgsXtQ+73XpX11nnoVD2jeTVIWJUeVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR0402MB3445.eurprd04.prod.outlook.com (2603:10a6:209:7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Fri, 3 Sep
 2021 22:34:20 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%5]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 22:34:20 +0000
Subject: Re: [PATCH 1/3] btrfs-progs: use btrfs_key for btrfs_check_node() and
 btrfs_check_leaf()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
References: <20210902130843.120176-1-wqu@suse.com>
 <20210902130843.120176-2-wqu@suse.com> <20210903140207.GE3379@twin.jikos.cz>
 <7946f5ee-13e4-c5c9-d48f-1d0fd80e5f69@gmx.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <d7262418-ab28-869c-87c3-62bc825160fd@suse.com>
Date:   Sat, 4 Sep 2021 06:34:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <7946f5ee-13e4-c5c9-d48f-1d0fd80e5f69@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR06CA0064.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::41) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR06CA0064.namprd06.prod.outlook.com (2603:10b6:a03:14b::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Fri, 3 Sep 2021 22:34:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 920c756c-726f-4915-4d00-08d96f2af884
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3445:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB34455DE7ED0D60849129F81FD6CF9@AM6PR0402MB3445.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lw9H96clQ/hhkJFgxlDJvy/gfAX0tGJNWuR22lXahQqmWZUHBpuow3LpfqeeFRY9YzszKeNDAgG/OYb2SaGGNpEhsyDHI8jI/JVEU4QpFG3CM9++ZKmdpjW+kKCBX0/tZtmzb02QssVV5pG2OGz/drmUPXY+6mq+aOJ/DEXioO1p10FWPNILHc+mqysOEG+eiNxpvratu4hB/ROdFc/St9NNSNUTThs6JF5xch7Bfnk/K7eAYcltqdz0Facf7W8rb80vYGQ0px4WSuv9rTUlvYJZSTwpWQFlQfEMdC983ApZubSoSjJjuWPhjbj0y7MIj5VjJeuYRsq7x3sO5Exwx9dl45thVtiJuEkNvIY47aTrIhpxfskKOeBRPEyCt5j4cS5NUHTjeeeKe2KF8KTn2SYdjf8yLddgGCOuq2Ad0yg61w/roBY7UEdzV1EQU8NGcQwjucRDnlZ+f94Z11E74MJa4GQeuTBBtmqiFKDERtSnhFG0jyUcWwx7qHmwM91Vw03Q6LlfTgJzTc32xn74QYktj3DgvlBw8PMew3UfDdTk6xMiCf5f/J3X2kknC7YoIXo/BjQahBEbydew2L1wk5+zKDvvr+byMEmlJ3ThhhBbkANTv0huxqMtHg/EvPzKpJWrsgOOw7xQgFyOPlzr1RrrI22CAOGpfxHJ8LiCwXG45MklxERjP1X8GpPGjRmQYDuWwngNHW2ppO6ZeAaR5gkKe5UQpKF8D6VHf5teYNVaSnVOOAX3rD2rXODDdWRH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(396003)(39860400002)(136003)(2906002)(38100700002)(2616005)(5660300002)(31696002)(956004)(8676002)(86362001)(16576012)(36756003)(316002)(8936002)(31686004)(66556008)(66476007)(66946007)(478600001)(6706004)(186003)(26005)(83380400001)(6486002)(6666004)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZFJFG+ljVdh+ElTDtIFtfK8l3VCpNY4vpJfO8/CiaNsZKMRfeWX/+WxDFN56?=
 =?us-ascii?Q?ErMyzJ7632g/4pb7qNF4Qoo3Ed1IpG5QBPqJydN5zi2dnMkxts3eC3cdBoRc?=
 =?us-ascii?Q?M6IVSVF9v3Lc4MckvGeJ37rTGesRNwOjBRuLtuLzWQFPu8fjVQrpIOCb3Syu?=
 =?us-ascii?Q?+P1jBtPFVIIISbJW9ay6GGHXR4eSO2NhEi3eULy0QTwop391S6q4A8JA1yhg?=
 =?us-ascii?Q?47Dm45uFGOcg2rtgN7JvwWeTNBQ6XBYTXieKoxh6vPQcW+E8ewiW3ehMFoxK?=
 =?us-ascii?Q?ePyq9x64G4XN0X63E8c+CjB/I/7cHSl1YWtXSIw79W1DMYxHk1UVwmV7LMWA?=
 =?us-ascii?Q?HBnkvCc3zjrZ93kcLk0XEqyEmeL2juJ65K3ckQPc7zBuAKmvUQQYKXv+jZxi?=
 =?us-ascii?Q?QDpYOHpfB4t7Sk142cn5yZyi4zn9E5mvfND1gnTGS+eTiJUqCCyWbpWTnKzm?=
 =?us-ascii?Q?aXG2UqAkYWDedJfB4G5LPlN4iWSdrKxFFqzizd2chPniB5xz6vV/L1Fz1DH3?=
 =?us-ascii?Q?sPFDtwnIyczVxcRXi3m3pX65P36wiEakQK3stVOxssI6cnHhlWfjR1LhXg4q?=
 =?us-ascii?Q?CPNb/1wVG+tHRqpux7jG3Caex6bHRykrHFGLB9pdIfxV+CpIuI4hZcJBUJKF?=
 =?us-ascii?Q?y/JRbAmv5hE8l7pNNb+Qr/1d9uxyYJIylvqNgynPK5t+2jZtiV7vyxzhRzG/?=
 =?us-ascii?Q?o3WeypOu/UZlG0nV7+on5svhPNGT55p6OjxL/YRk/3c2rVEwexUhVW78G4kL?=
 =?us-ascii?Q?VOtIJbRlFqNTwC9RTfYSojSQBCQAA6zHSIUfTPUiDl++DR7+nSbFdzaUTxQX?=
 =?us-ascii?Q?+kCHC1cxB7kDaVhnWshALxQHIWr534DXmcZTSH/rItoKopCJdwUIK3QLeCIa?=
 =?us-ascii?Q?odl8w2b9LKkZU7OVA88gf47c1uzQ2tpMxnhWwVrsez6GLhzPyLW2MJYdD6T1?=
 =?us-ascii?Q?e+KZlBbaLI/EBLRUMwSi6jMQWlyzwFbagrMg6aIMSE1YJRGKDPypCnkbtzs5?=
 =?us-ascii?Q?NJpnIHbNUAc9Z29ZJx9LsYYf8K6fT8iMd1FEzfp1VyU2R4sXfmWqh/pUhZRF?=
 =?us-ascii?Q?ZfIX/jBoVXiXoEl3E4cPaXkaaCq724W8cGyHMzksxHAGK55iNtAkJ308nBB/?=
 =?us-ascii?Q?/8TdbUq124QvfU+0sDBuFWGN6QPbbqeWNa97xjCPqsZ230uHAvZcBfB3NS0M?=
 =?us-ascii?Q?GzY3HNxNEX8F6+RgAlnbfOlnaFVF8DvYr27rDKpKIrPHG+4MEl0Hf1esRRjI?=
 =?us-ascii?Q?8oOvyfCVSxts+PW++mo3iq/wrUOWVw4ITcQCL6JWdR6qT6jSRzcVdcUfRhnm?=
 =?us-ascii?Q?9CIjQiqXPX/LhCfRbilTepJ5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920c756c-726f-4915-4d00-08d96f2af884
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 22:34:19.9560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8O8vZEiUXPLEnHnfSLFKFfu2u5QBcWfRgx+l8z7rT4DMiy+0Vtvk/ZAe2KexkcwA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3445
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/4 =E4=B8=8A=E5=8D=886:23, Qu Wenruo wrote:
>=20
>=20
> On 2021/9/3 =E4=B8=8B=E5=8D=8810:02, David Sterba wrote:
>> On Thu, Sep 02, 2021 at 09:08:41PM +0800, Qu Wenruo wrote:
>>> In kernel space we hardly use btrfs_disk_key, unless for very lowlevel
>>> code.
>>>
>>> There is no need to intentionally use btrfs_disk_key in btrfs-progs
>>> either.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>> This fails on fsck/001 test
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 [TEST/fsck]=C2=A0=C2=A0 001-bad-file-extent-byt=
enr
>> failed to restore image ./default_case.img
>> basename: missing operand
>> Try 'basename --help' for more information.
>> failed: /labs/dsterba/gits/btrfs-progs/btrfs check --repair --force
>> make: *** [Makefile:413: test-fsck] Error 1
>>
>=20
> Not reproducible locally.
>=20
> And of course, for such lowlevel change I would run all tests on it.
>=20
> Mind to share the base?
>=20
> I'm basing all my patches on the following commit:
>=20
> commit 06bae7076265242f118471ce8c4340dcc5e3f555 (david/devel)
> Author: Josef Bacik <josef@toxicpanda.com>
> Date:=C2=A0=C2=A0 Mon Aug 23 15:23:13 2021 -0400
>=20
>  =C2=A0=C2=A0=C2=A0 btrfs-progs: tests: add image with an invalid super b=
ytes_used
>=20
> And I also re-checked the test on this patch, it also passes locally.
>=20
> Thanks,
> Qu
>=20
Based on the latest devel branch head:

Author: David Sterba <dsterba@suse.com>
Date:   Fri Aug 27 15:34:57 2021 +0200

     btrfs-progs: tests: add mkfs test for raid0/1 and raid10/2

Fsck still passes with all my patches applied, but only with the first=20
patch it fails.

So there seems to be something conflicting, will update the patchset if=20
it's my fault.

Thanks,
Qu

