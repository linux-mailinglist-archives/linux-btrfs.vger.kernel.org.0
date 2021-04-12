Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA8935C88A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Apr 2021 16:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbhDLOVa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Apr 2021 10:21:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5723 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237789AbhDLOV3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Apr 2021 10:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618237271; x=1649773271;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=d+HtNJ8xZKHxRNWGYMMttLD4lzWZugFleYrYxgZg788=;
  b=bZcK+1IeOdWLya7wH1Aq64LZh4g0UDWrXTYcA9W45qEB0bw5bMv+TnQw
   tqZxyW5A3VWfPUSf/0+ii7zzuQ6wUh1lAbGceQSW0bL2r9stUM1Iw2uYO
   u36xJAcT7A2vdmsX79C93PE6JrLBLfK8NWE8MmwghNXrmZnbHfS24l5fK
   DfBQuhJe0n6uewQ/+4GptUOs93PFxe09NDLQ34TXRb0m73eSF1KxBEock
   nFFv+GfFv4N8O9L3HaJFC8t57Q4g5m4ttZQJoF3TOKCxS+yemv/Zx8SpG
   yf1wwAU1wdyOCLbjuNth3Z6qClMNMjhj77usuCPtkZa+flXsVUYhUpjlv
   w==;
IronPort-SDR: bLnW7SG/i5TP09WqkT+jtU9ow3kj7LUGUjP5vuuMkq0blNOvdFlmKUBH1sFgGjM89366d7tpAd
 nRbnS5vMVk3eGs/Wecs8dPahnCK0K/zgAir5kSXRz0DgJEZGf69XBlf3SvaBWOC2+FqJxowCMk
 58i1kNiuWJpLGVsRus/hUCUAbwsjHMcb9JLUfS8vOPHXYrlg0HKttR+aGmhSH96GbnYkxHme96
 A80t+dOGA3SbNVao0N9psbQJzKK39dLuoS2zmkCBvZ0S7hjZuvW1P5g22kEJySHDqwt4YInjp+
 lYg=
X-IronPort-AV: E=Sophos;i="5.82,216,1613404800"; 
   d="scan'208";a="168995870"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2021 22:21:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acbUk1MZbaCTHnr1SUrHoA39g024u3j+X7KrtWJSvdKNlmwTaj+HF9KDsXmZnwn16FmdYiXecZBthKzeXtimPdmF+3owZv+g6Pz0i+mHerkaTaD57c3dTrxLRIS2plaLiv6M3ruKEz7Pp+i4m0tuRom5XQwkQQZjWn04waNZy4XijUkmEC4a5w8wbpKrdpkZKKuTPoiFIpHk2MD82nTrv5s+VCUowLHX7MlLEKbkQAYnQ7mt8osUSmmz8kPy459+0jB7V07ZgXhK1InGXwKpLAjjLNAhaMFaWS+l9wjMmFAsduk+hdMmBFEv4TaFYVHCKykS43FLc2kYFAPP4eRg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVDEOJX3maUq+LFPM0VU3lDKbaXf6fWAKQ6mpt2LSro=;
 b=NQhkXrHAhWfxkNIeJNysg7icq5qOQHjT7aacQdDX9t8/k7uAXc42BXM9kAvvsqplQQ4X7ZTzOYtm0CC0nZE+FuQRLHQ5miEHBIj5kJPDI9P3aHeCDjyj8cx9HHSDTkarSmQRZbyBWopWH+2Ihjz8ihOIgZeSnBZ9GmSypN17keO5Y8++cXxGs/D8qERPTeXtmDdxJp5BsZwWQxJMKiqgRdnyuxaDN/RBt6xpoAnLMm3j9ybB6h9syqbpv26zN9Urm829nQgDxGAUn/2+4Y/fzHfwuBcZs3ywthmkCPuO4KGeyPhe1jSh5SPEhLJytMi0oe0Fl9WEfXNchFTPPNo3Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVDEOJX3maUq+LFPM0VU3lDKbaXf6fWAKQ6mpt2LSro=;
 b=LRIFjRZw/AbiuM93Q1OMKaZaSL+pfYOHPn75xm3tXS71/1PZHjaVYlwdfAaU8R+qbiQRQbZjr6/L6z5V7QQ5yO6mh53Hvz2QBHOi70lKsp2f/gtFogcxtpRs9x6bu6RVelCwsJn2HqsOFBhKf+TPazhmPcf4zVa59phbbJq0vng=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7669.namprd04.prod.outlook.com (2603:10b6:510:4e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Mon, 12 Apr
 2021 14:21:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 14:21:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>
CC:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3 1/3] btrfs: discard relocated block groups
Thread-Topic: [PATCH v3 1/3] btrfs: discard relocated block groups
Thread-Index: AQHXLS6OQPw38ZTTm0ORPeiHMuNyDw==
Date:   Mon, 12 Apr 2021 14:21:01 +0000
Message-ID: <PH0PR04MB7416DD1B232F797944ADD6EC9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1617962110.git.johannes.thumshirn@wdc.com>
 <459e2932c48e12e883dcfd3dda828d9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com>
 <CAL3q7H4SjS_d5rBepfTMhU8Th3bJzdmyYd0g4Z60yUgC_rC_ZA@mail.gmail.com>
 <PH0PR04MB741605A3689AA581ABC6CF3E9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H55vudYBNFGHWWuWCaeMLuVm8HjbBsmTYD7KQP_dKEKOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0715a36f-4b8d-4c95-cc30-08d8fdbe3338
x-ms-traffictypediagnostic: PH0PR04MB7669:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7669AF3C4AE17797F286E6F49B709@PH0PR04MB7669.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ci/W1G/BSwhjUVcttpiIbjNT9aXC1yeK5vQvaWkZ45T2MyxvP7B+yimQIb3hTXXwn8QN1mrvrF1kaLsoEpx5zMkLiUbqMSvHC/9AwXAtKWJqQOevwutw29c7Ifw7qzAK6OowUWRIKiTb1q+APp526ALzrCBmXWvCnbYIAXjc8wPSPCFgRUbldS/A9etiGHdLwb94F9fSa0V3V1hegFACXa4UJ1GXWY7WswAc0nh8DMec7JdmjUw88YVeO/BzcpynimrmLlvYQEfifhSha4p+dFzByh7f7v7w3MyizaxnyR+zfutfxZZTQruoFh11JvtxhBpufgvQjqw0mWx2TSIAkM9BaJyygddTRlgZmKc+AETVJAyThDj3H2DTBIcJOMDiSloYZR0DGKvrCgsd2d/fToapvgXiOBfcVuXRVjo2EHCXYN79kFeXDcEw6zVWgJnohlBHWVQhfoi48muJ9jLo+BXnxP0M04dOxrJubFxXIFN53o9nEXvkPIuKu+ClK99TpgX7fZ7FmTg6UOpGoVvW4UIDTi0Zum4FGZKC8Hd4xfk+3oio6eubc3GPqZZUmaKqwJ2J/6BuusExoCFt9oBqq+UeMDYxY6q2tYz+lP5htW0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(33656002)(55016002)(2906002)(7696005)(8936002)(53546011)(8676002)(478600001)(38100700002)(54906003)(5660300002)(6916009)(83380400001)(52536014)(26005)(186003)(66946007)(66556008)(66476007)(66446008)(64756008)(71200400001)(4326008)(76116006)(86362001)(6506007)(9686003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NbU32yuPkFDeeTOSE3pe700FchZ36MT/fFbhF9EGCNTe/cB3qS1YLmFPmJZL?=
 =?us-ascii?Q?51B5wQezeAxuuJv27p7KOsmbcFVGpV2fYZ5BMTOJjXWQAjUqANDJQIg4wQxo?=
 =?us-ascii?Q?fSiW6yFJWpEwH4z4m8Q9cATJFAKn9g49li/f0CblL7ns7Ag445y2ixFSNVu0?=
 =?us-ascii?Q?Yud/j7eSign39t4Dxnn1ORN7GZ+IFBqCaeLEFZhd6H0gVpCvCMmur4ww1r8Y?=
 =?us-ascii?Q?0i1p9Ncdx2wkbaJAa/tPXoa3m1XbpACEwVMAC1eM0OWNyWLRXtnJcU8be07n?=
 =?us-ascii?Q?GN3Gk+D0aRPhuu3TqSlBfWC1toe8qCc7YJV/8FPFkrQb4Utcv4Jdlrc5ddaw?=
 =?us-ascii?Q?GpBv8OOHSBVh0BJiW8qgYN477DL3/vWbkmPhzcyfp7q53R7GUveQrASQvMsp?=
 =?us-ascii?Q?SQGVQuqjPM1K5nyZH2qunwtOldo7N8QtvqwLhx9ZUjvDMAYzlRw2dEwl9Otx?=
 =?us-ascii?Q?/vYqjlCqPil8uvH3fglOMq0XRu3iqhNKTvYObipXIIMflmH6DlQzOdB+d3SO?=
 =?us-ascii?Q?mkLaw/dELi+8NDmWv8qjsXZZ5lGwlqNo8m1u/OofD8sWX7vef+Ep8jIun6ME?=
 =?us-ascii?Q?X9Xod7c7JGPe0TG2yVZkhOO8WShtTbedF5m6mNs3896YH1pe8PAdHPjhkZ7X?=
 =?us-ascii?Q?D55YxQUhfliXDPyF2CCNAiGk1ch/iCt0DoZbZsINfe69IgABY3Z1XgtnbZ3T?=
 =?us-ascii?Q?8/rEiQLMBCIEdNKKWsFoelSd/sqfwlig8KF7+F6UXA5eKX6LK/4MK4AqCYfa?=
 =?us-ascii?Q?NP9JR6GCCdSDlHOJgNrGvAJ1NAeC+P9oyzbMBY9uzGUOKMfMksRwGhEt8CQk?=
 =?us-ascii?Q?wwXj5njW1/TDv0TSJf2Y9G72rgxvi7oWW02SiJ8kDoKIHvDvzCrBBNzFgY+a?=
 =?us-ascii?Q?U32iWAO9DOZaUTZwYNHGMbBWZei0wFgj7VauKyBixCyMFWJWzCdU4eScago4?=
 =?us-ascii?Q?FQF3N5h2HJAsS+GRzoBcEgs8+Fst0CF/l7RejaV8oF2z9E5NXrCf3+W+Eub3?=
 =?us-ascii?Q?IQvB8zHJpvwo9ufUIilU1UMoH4InYUOKxWrJwLlrPyfTY6eKbW0Q8qqt3kHG?=
 =?us-ascii?Q?p8EPsXbXPYwd0DdSWdGBf5Xh3c9fDPC/rbRUhW2k3ccxyIGxeTN0o9935C9L?=
 =?us-ascii?Q?gwbFxIBX9v+UHICZvySzcBZIaC4jZCzGfkRiN0tqPJokKKm9r8tz8e185VWi?=
 =?us-ascii?Q?wP/TB1j6qWrckhIEiLoSVvsIGgp7CYkzRX/AYGxC5IT31UIOqQ4zjMh6Pr3F?=
 =?us-ascii?Q?2PPT0UNPaQ6EXZGnkoojoIMI+mT+WeTjdET3f1wC+PIESJx3ZCj5/crhNEpc?=
 =?us-ascii?Q?1wl03SrJQYOMD9BdfR9sUgQb8bN6telUMiAMK+F3ZOwg/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0715a36f-4b8d-4c95-cc30-08d8fdbe3338
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 14:21:01.6246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wb1JZoWIpuEaTFKdGLQ0e04EqWv599h1cJ0is+8M57PS7euoWq2FKdE1Mc7EMvk7AEsRViyCVkchCSoX48OWeeVo8IPIPb8bHLJ5QFd2JQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7669
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/04/2021 16:09, Filipe Manana wrote:=0A=
>> [   81.014752] BTRFS info (device nullb0): reclaiming chunk 1073741824=
=0A=
>> [   81.015732] BTRFS info (device nullb0): relocating block group 107374=
1824 flags data=0A=
>> [   81.798090] BTRFS info (device nullb0): found 12452 extents, stage: m=
ove data extents=0A=
>> [   82.314562] BTRFS info (device nullb0): found 12452 extents, stage: u=
pdate data pointers=0A=
>> # blkzone report -o $((1073741824 >> 9)) -c 1 /dev/nullb0=0A=
>>   start: 0x000200000, len 0x080000, cap 0x080000, wptr 0x0799a0 reset:0 =
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]=0A=
> =0A=
> Not familiar with zoned device details, but what you are passing to=0A=
> blkzone is a logical address, in non-zoned btrfs it does not always=0A=
> matches the physical address on disk.=0A=
> So maybe that is not a reliable way to check it.=0A=
=0A=
Yep need to find a more reliable way to use in fstests later, but as of now=
, it works for debugging.=0A=
 =0A=
>>=0A=
>> Whereas when the this patch is applied as well:=0A=
>> [   85.126542] BTRFS info (device nullb0): reclaiming chunk 1073741824=
=0A=
>> [   85.128211] BTRFS info (device nullb0): relocating block group 107374=
1824 flags data=0A=
>> [   86.061831] BTRFS info (device nullb0): found 12452 extents, stage: m=
ove data extents=0A=
>> [   86.766549] BTRFS info (device nullb0): found 12452 extents, stage: u=
pdate data pointers=0A=
>> # blkzone report -c 1 -o $((1073741824 >> 9)) /dev/nullb0=0A=
>>   start: 0x000200000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0 =
non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]=0A=
>>=0A=
>> As a positive side effect of this, I now have code that can be used in=
=0A=
>> xfstests to verify the patchset.=0A=
> =0A=
> Ok.=0A=
> Maybe the zone isn't reset properly because the default mechanism is=0A=
> doing smaller discards, on a per extent basis, and perhaps the order=0A=
> of those discards matters?=0A=
> =0A=
> If it affects only the zoned case, I also don't see why doing it when=0A=
> not in zoned mode (and -o discard=3Dsync is set).=0A=
> Unless of course the default discard mechanism is broken somehow, in=0A=
> which case we need to find out why and fix it.=0A=
=0A=
I'm at it.=0A=
