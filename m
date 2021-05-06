Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C18375451
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 May 2021 15:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhEFNDl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 May 2021 09:03:41 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:28864 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231265AbhEFNDl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 May 2021 09:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1620306162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HynRgD4M9Ym9U1VBoZWvfWrWJjsoCi88IWUOtoKq150=;
        b=GaIr3LtXNvIQe5TQIvb1NCZ/pSBrXwFGFeS4cn/e3Bwne2W0KbLrVT+KxlKW8/Jdk+TjzB
        ixZkS90vhAJe8nFJjlJm4kSkFwdpcQBVGHMWEyoP7aHGU9pMQiqhVB3IMsrOWBoyofpiVE
        ai6V50YVay8smjNBNhX2s2UlFC2k09c=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2053.outbound.protection.outlook.com [104.47.1.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-5-h8I12pBFMNS2f7IS4gNK1A-1;
 Thu, 06 May 2021 15:02:41 +0200
X-MC-Unique: h8I12pBFMNS2f7IS4gNK1A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoNZ9HyXPvmhJx0lqP3ARaufojJMkcLqJsixLhu70Kw3XTUHt712TamLE1LIHTJfulo8ONL+r0bBEhN5Ti/eiPBrkDyfm3TrzLmYuvuy/onCUBNeMsnnmNBtH9tCI8q+FmZgtFRRtMMbXfDGS5Vrrl1ysTehbJdF4ELkqIdCTwyJB+VRvevqBt3M2pC14Rs5v0au0d5yxJC7vmgXSoUcSgOUazVExP9h67+XjfdTSIl+BKdzOKIjb+F/QqW+Q2F03VLPHDVLu7hBeXNHWOEO+ssy4wO3uz9VnCMTau1RgRoev1KfAhitrT9zbxpR3pCSAUNlw12lSCdhb58fa/v80w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZv2h+u+uaDAGC8szWbJhn0SBPtET7pm5LBdVkuofDU=;
 b=jwQ0ALF1Daf+HJnCQZWJxGYevW6ERwJU1RRvInCnE5ZSFxyqs2KmXGi+DDCgduQScnbfdtKCX4wdeUYhqGGW0mCEmoitSuC30O9Ym6q14G112wwll4sOIYqJgUyKskIZ5OnCXe04ouXKODSgAAu3SJ6ZEORUuCJwV/MiuaCnnMaM39cZAvKT4W7SRs2yWPNfAqPfC3PxM8RhF534dSF2oP90noWe+kDuVEKvDsT/2RtAIyDFW1Xu6F4EvE4CiVbsSrPajulrdclC2tB1RiowgkMq1Q7Yas2RzRwowVHd99XtJcI0b3cH3JA/wG2kKiTr+sAYJjegTUSa8QDlxleS7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB6071.eurprd04.prod.outlook.com (2603:10a6:20b:b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Thu, 6 May
 2021 13:02:40 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7%7]) with mapi id 15.20.4108.027; Thu, 6 May 2021
 13:02:40 +0000
Subject: Re: [PATCH 0/4] btrfs-progs: check: add the ability to detect and
 report mixed inline and regular data extents
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210504062525.152540-1-wqu@suse.com>
Message-ID: <6d00789c-eaed-e99a-8d71-f693bb0be5e7@suse.com>
Date:   Thu, 6 May 2021 21:02:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <20210504062525.152540-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [45.77.180.217]
X-ClientProxiedBy: TYWPR01CA0035.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::22) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (45.77.180.217) by TYWPR01CA0035.jpnprd01.prod.outlook.com (2603:1096:400:aa::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 13:02:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f46cc0c-98c2-4261-5a98-08d9108f3a57
X-MS-TrafficTypeDiagnostic: AM6PR04MB6071:
X-Microsoft-Antispam-PRVS: <AM6PR04MB60716420BFAA4E8D563CD8E3D6589@AM6PR04MB6071.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: klA7k+O+nodsv7kne6KNwcZ1+MVdklILNvLLyvQ1j/mok92PAVjBjmFeCn1d+VjVohKkxTWoXTE7gVFvogWPdfB4BIgdCniPb5tWybYLMA51aF/AnscNpCBhloTpOfZJWw9gIGBV/G3X+9FO+5PgJZdi4PLbREukM3G4fsEeNnA0anY4Qk4ralAwWCay9+vQ40F2BFo0uA4Rt6FrGzov7P0UdFSt/kSFttdVD6eR1zQk8FrOkjwgwUDTVfflnHD8GDuH0kD6VdLLcLELNlFUUPvylyM+b7s5uFhMeaINW/Cs6tGT9iuiMcSe3BqcI7ATYuml0sIyHFKwHUTuo4pE2sMBzo+neHrwcuEoVSM0hyiq3ymGtXUbq/Dte58zcYQpc3gWIw5JxGLkxcjyGGsFJ8dzpPKbyBsGgiXOBO9l4YZ5IW+dhMuc1gF3z8ga4DESvuTOe5INRkWs0h6wDHwMFY0xTaweWJz8zj3sMjyiG1m7kaP4Fj43pwvvSZ3qCofkC3lywM/q5rgAuzNh/laBYVkdhl+LWV4j8A4Bn5NEi3Uz8OfcnLcro87HhURT15DV+bI9U16muS48tfP5RSpEFOX6vrm9SWNygvFSOonJcPWGyslNyg2T9bBZTcjGKVG7wkSyonC/+ZHXDA8S8hN4HTKhIBI30MZNfn8+mBj3ti9EzvYhqQ6w3TgVVS72/FTk0CCi4mLpCrHwGupBitFhElHYlZggZrpOx7Aa+3nH9aY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(136003)(39850400004)(346002)(6666004)(5660300002)(478600001)(6916009)(36756003)(6706004)(186003)(8936002)(16526019)(52116002)(8676002)(316002)(2906002)(16576012)(956004)(38100700002)(31686004)(6486002)(31696002)(26005)(66556008)(38350700002)(66476007)(83380400001)(86362001)(55236004)(66946007)(2616005)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Xb4+HO8/752mbcZKRp01oacHw2qsLWjeuKEQEXBq7NFNuQC3vh7cFaE0FH0E?=
 =?us-ascii?Q?tYAo6oHeUIkOCYuydnr95UcZY580pkBhuhsmtcF4HHuCm8nuueF/aU30NPuH?=
 =?us-ascii?Q?Lxa2t/h0UluSYKTTxBW2x8J06bC5wzHMcmevrg1+xPmUJjCnWz8YYiLpThKe?=
 =?us-ascii?Q?eb1EEgDKBP67Ye/TxQ3U5kgXPebl6oSOacQWQAZl2D4I/Eiotz/IaYvbrByk?=
 =?us-ascii?Q?tJa1fhxvm+3g6PB4KJhv+0r6zb+RSb8WMGgsLni7mbl0VYczLOuXXJslySl6?=
 =?us-ascii?Q?bvjAFu43yeBtUXR0r8TwD82besekDKJBMsFUi8UVjYZn5AQRZaF7Nwn/56Hg?=
 =?us-ascii?Q?l2zZXjQ/75fBmswlkvNCHoOfEcVvsXeZ3QgGsv1PHdlGr/Lufp6ZjTU7rL7V?=
 =?us-ascii?Q?6/UDBoTfedYHRHvZnBj07rXJdu02pOQA0QIUuIT2eKjmemw6LFdvda1gMNWc?=
 =?us-ascii?Q?vJSpGC2ebkbUTJXS/ZwpNRgviALZogVIb+1g3tj0O5Dm2BifZ0p9OnMpTg22?=
 =?us-ascii?Q?BucoF6fHMJ10DCh5cwjygU+WDjylYdaYKEQjN8rneBHpw2z5jDo8PUBCQacO?=
 =?us-ascii?Q?DTnCwVbd+SH62FU7d57Uvciczq9DTMijsiv+7US3SuBU651AW+mUkHXaC3XH?=
 =?us-ascii?Q?1aYpV9vDhsiL7lvOFtAbzfctNjWXFRFj0e8GzNDB/9u9ZUHvV92+6936BKp5?=
 =?us-ascii?Q?Ok/FVJhA5qxF2HA3YGc9v2TdYHEXVIzQcw7b4NWSUAk67jylWNWrMhVhrcbj?=
 =?us-ascii?Q?GPcsHG1yVuPe6hYzlAcRlfO47jjxppNCzFovqSM1Sj89EGTJW7JuUA2pfQBn?=
 =?us-ascii?Q?8q6D27qi7Lw55RAPaiqWP6Nps5HAVGpCJHZLibBwDaZpg2DgdansWDtzPHQ8?=
 =?us-ascii?Q?GRoJX4oZfTXVLS19TDMGJ7fWKyFXwn/uEo26Y7QHjgYkCQDwrceiyRMzd044?=
 =?us-ascii?Q?UQFz8wLPpudCXfQLVcs2mXBQz1huHfuFAmxq3cUgu8AS0nHRqst02Q0Jk+qu?=
 =?us-ascii?Q?gBjsXCS48SI5RQucDRz3yV+bhZWnTVPKnrL+UgiwXlotAKgByvewofykQ+2W?=
 =?us-ascii?Q?1EUVsa8HPS8bvLDubMKg+CeaJ8PaTW1w2MkFaeACYXKNtsYQ7iMlRWGTHp93?=
 =?us-ascii?Q?5J90jBShBWY/Aee2xJPGCtLN5fZh1aaFx39gXi56KZyntyZPtvz0XUtB6B2K?=
 =?us-ascii?Q?C2ozt0QEG0Qx0OQLzsUkFzRwNODnAyD9TB4ZGxCw91uctxTFI5QPucdpI5td?=
 =?us-ascii?Q?WkGAr1HOm6vAp/EADKTpyoGB143GgF1ADH/bWB3uMpKEZ+87e/OSXSCYarx+?=
 =?us-ascii?Q?Go6FaK6yigaOU4sco5sYwFHP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f46cc0c-98c2-4261-5a98-08d9108f3a57
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 13:02:39.8998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0yzLlnbR1tWYQe4dn1xsT+eKKiNUJkbhbfnJJUdR4EmZjgwOu5pdnobmM9KLCB4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6071
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/4 =E4=B8=8B=E5=8D=882:25, Qu Wenruo wrote:
> Btrfs check original mode can't detect mixed inline and regular data
> extents at all, while lowmem mode reports the problem as hole gap, not
> to the point.

Please discard the patchset.

We don't yet have an agreement on whether inline extent should be=20
exclusive, and since kernel can handle it without any problem, it isn't=20
something that urgent yet.

Furthermore the fix would be way more complex than I thought, as even on=20
x86 we could reproduce such inline + regular extents, it's not that=20
worthy yet.

Thanks,
Qu

>=20
> This patchset will add the ability to detect such problem, with a test
> image dumped from subpage branch (with the inline extent disable patch
> reverted).
>=20
> The patchset is here to detect such problem exposed during subpage
> development, while also acts as the final safenet to catch such mixed
> types bug.
>=20
> Qu Wenruo (4):
>    btrfs-progs: check/original: add the "0x" prefix for hex error number
>    btrfs-progs: check/original: detect and report mixed inline and
>      regular data extents
>    btrfs-progs: check/lowmem: detect and report mixed inline and regular
>      extents properly
>    btrfs-progs: fsck-tests: add test image for mixed inline and regular
>      data extents
>=20
>   check/main.c                                  |   7 +++-
>   check/mode-lowmem.c                           |  31 +++++++++++++++---
>   check/mode-original.h                         |   2 ++
>   .../047-mixed-extent-types/default.img.xz     | Bin 0 -> 2112 bytes
>   .../fsck-tests/047-mixed-extent-types/test.sh |  19 +++++++++++
>   5 files changed, 54 insertions(+), 5 deletions(-)
>   create mode 100644 tests/fsck-tests/047-mixed-extent-types/default.img.=
xz
>   create mode 100755 tests/fsck-tests/047-mixed-extent-types/test.sh
>=20

