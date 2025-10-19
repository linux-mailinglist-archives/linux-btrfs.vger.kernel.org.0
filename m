Return-Path: <linux-btrfs+bounces-18017-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9253ABEEDD5
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 23:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8E23348C12
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 21:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75B323EA86;
	Sun, 19 Oct 2025 21:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="SyJuGFWi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013027.outbound.protection.outlook.com [40.107.162.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C50A10A1E;
	Sun, 19 Oct 2025 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760910825; cv=fail; b=nRZXEXRWxUYlCK/3gUwv9nKiiRCaDEBE5JjIeVkUSvatWVsZfOnTNbvMlAmdojRB/NyQ5Yfj+wBDEFrqXEIAdVkwQuztIazvdhZeJqHtyI9XIH06j8t5l9HkrC93L9wpKQcUyfz8mz26fNN8heLvI9uSjG9bnjytKLcCSL9K5Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760910825; c=relaxed/simple;
	bh=mGsZ2+cIx0dEpgPB85zk2xr5c/lsQGAhIVWmNAi9Z/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=HUPy/Sb851/1BhMEHISSNXm66nABpQL+8tiWHdbV9VOICpRiUsN91ONVVmiYzBp+ZqgHBANcES/jvKQo9NB/3Tff9NE7x8sPE4fSsQ5YjJNV2DiTAm0DXxjpXjyQBFxlqJ6vSnsBL2oq+FN5iN5jAGqSCkZ2N6XPPlTT0FRTKWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=SyJuGFWi; arc=fail smtp.client-ip=40.107.162.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOH9t7cE6E26QCEF0vjbzJ0EdjuwKWbHiyChh9J65A1wSNxt0SgFAie7qDLAQiRquDwM+QBzKwhfVhCh40jxgp2TlaSV81XURBPZJ6NejPxUyW0VfW5ly7MNwE+mSSR49zfAIk134daCAx2X59SOs3Ryc8DugJ4L6cOVwkshoAEfYKs86jnLpFMBBRIiiCU7ltFDDldlc47A8clukUxjbVBbjC136tCqL5mYJp5gywHj6TL72kYTi6kRajPJmRSOl2m9BGQt4/pxjLq6n/guj6bJfeZ2qSZtXwycPNrO0DdVlXSNP+nW5EXg9/zr/bdcH5iMpd3yxmF6wZ+YlnIrlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUH7+7eGMXixgD6CW3ySl1Og9WuZDEVrufXeaT16pTs=;
 b=gFWxZ6gmZeP2JGFbV/Hvwi7/Rd2+ptxaQe+OgDc9Y5tN1UYa7xRI/CtWRp5Impkv7Kamg6MOBqgUBmnx+jQS/PPJ8HVXqccdTNYse8T8xnoCo98m6bIxETn1+rMJgnP9YExBtVoMvmD3TvjLk548SbqB29FTYzx73Wo5xmU/5C8EVOi36uwnQ1tWHTf1RdePFSpugoYHtuFhK7C2vFCDYBZ7MrvtslQyDQv84os21D3PumqEHWx9XTaQerJwHEYMVC7MRl6SbJ7AX6Qcdc5k1OihmAUDxNHCjZl9xivHKRQ0rlLgAU0RzjthZXy/8Ew4PbMa0x+MY3rzn1oUqAzEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUH7+7eGMXixgD6CW3ySl1Og9WuZDEVrufXeaT16pTs=;
 b=SyJuGFWiUcPeBxCdaRixnSKJwxzYOwBlgf8r6DSBiIskHODytyCt/a24weLhedxUXjYfOsA1u6DVO7QyDQHgL2NBoiiUtaoUagkEtn6kny3Hi0qiyyrt60wbUleHC3IJU3ZFF2QW2EkWQwltFjDCM/neLd/NM/NCgbNA66LAToc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PA2PR10MB8649.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:420::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Sun, 19 Oct
 2025 21:53:36 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9228.015; Sun, 19 Oct 2025
 21:53:36 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Sterba <dsterba@suse.com>,  linux-btrfs@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs fixes for 6.18-rc2
In-Reply-To: <CAHk-=wiiysgAErOobR02zECiniaM69AacAHjTOSKsv3yDF2R+A@mail.gmail.com>
	(Linus Torvalds's message of "Thu, 16 Oct 2025 10:58:16 -0700")
References: <cover.1760633129.git.dsterba@suse.com>
	<CAHk-=wiiysgAErOobR02zECiniaM69AacAHjTOSKsv3yDF2R+A@mail.gmail.com>
Date: Sun, 19 Oct 2025 23:53:33 +0200
Message-ID: <87plaieexu.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0410.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::15) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PA2PR10MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 814d3a6a-ddb5-44f7-0944-08de0f59f47e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4J9BodKY46t2V7mkK+IUexDVuG1IhKKCadwfiTfypEqsK6UuxC7cYASsETbq?=
 =?us-ascii?Q?XK5ylAgIYdXz4wH/bOaJe+WFeqZ+rZ6eUgk/Uv9m7YSo9W31Tf5OvIDJG/Y4?=
 =?us-ascii?Q?FeI2zDZ289SLBvMAytU+tutSniKA4X64ZL4A1VTBN6hCbYJHP07eMf6UlYsr?=
 =?us-ascii?Q?IuVgLW7veflusMsvUvx/vUn789U4+O1EH/Hg4U4eW0TwiDUCYUSZk7UoIM4w?=
 =?us-ascii?Q?jSwTsi2zr3ztYYynhhs/Qpe/fwsbrais1jlaLvgfb9tRcGKelvdr5yKoJ1po?=
 =?us-ascii?Q?NtAoCakAaRrtCCDtq+7rFHilwU+ZoV4B2XvtQ8dqvj2CowN8M1vf9LGroL5L?=
 =?us-ascii?Q?QE5vLDTRTDknT8QzwZ/DI7c6WHt3FQ5dK5ErTr3DSWzT9CX2zqJ8drC20YTA?=
 =?us-ascii?Q?YHi4GT9aA4JcfAD03NOGMogpGosx4/opjvhIlzDH/DXU1R+Hb9Lsqc/Qxeod?=
 =?us-ascii?Q?losw8Oqxqq5CuYGBoxyEA5UjtyDUPSIbNSItplbHhEutAzEykwyGynx5xoUy?=
 =?us-ascii?Q?rMzici14N53Y9E0goyvlZvk9W3oZAmKv58G1myqPtj98Lh33oWPLBIVv6nXX?=
 =?us-ascii?Q?7SDk7yCnozMJSX0bHQ8HIE2uz1jVq1tCYpiiDggFtH0MAbZGJ2tVRAJKL+Ay?=
 =?us-ascii?Q?N/4Lbh5zjD+JxDLOEt5s6CkCgPOQwhOZSblcmCnv9LW/SPkwdfqEdRiADklc?=
 =?us-ascii?Q?iZXV3zQfl+wGuLGlRmtw1TaEB7cJ+c1ainUzkwkhZXWcYnPcYnly6hhY7dBo?=
 =?us-ascii?Q?EZM2d+wxcLvc5L+EhRzmP95gfJMuxXP75qiEVG13rHLfGlfSawmsbsX5YrWH?=
 =?us-ascii?Q?HpSxlLJQABkNCml9Z7TVt1lFzi5W2o06RDd65rUwBZwHI7IvxHpcFlZzezg2?=
 =?us-ascii?Q?2JVxFsaYXqjnJ1rGyVgCgJlskdxejbuKHyEEetY6hXy5qAeuMMKdnWVIBIIM?=
 =?us-ascii?Q?YjT8M3ugUg89pYSB+/Bs7c3KgiK22Ce67syjKDOMX9OFODr0kOGYP4IQHifn?=
 =?us-ascii?Q?uQ8LJ6JIDvGdqF5uG+IzgAGqRr08PtDv5CxuFkjMe/Hp69+BgGNATXpJuWuW?=
 =?us-ascii?Q?19pzA2HVRaliMBKOfDQc3ABWAFvPJOdJrFlj2oeSZ+RFXrIkUA/g4fKFrrav?=
 =?us-ascii?Q?dfzte2CBGvp73wNsTAZb/ApY4qGKG/0m99LE+4gXn9Q322Ol24tjp3gNnrZk?=
 =?us-ascii?Q?cAfmEod6YzXXHpzgTuJrhNG1E6JfJWubbqC4oH+qrQZJ77BkDUsyAxpkgNCK?=
 =?us-ascii?Q?x+/YD+AvSx6JKDt2pwtpPzdrMDV9PSY61oq8B+uOSqJrChfLexxF0dMIQliG?=
 =?us-ascii?Q?OIfgI+P/U8V5J+qA3y7KJCYwOkObA+v0WAmCJDTLNdthI1GTb87LMtoB2xYF?=
 =?us-ascii?Q?iQIe++E+hNI3K9vk0eKHM4AFS/Sgu8rC6V0+ukYZp5CAmlKXSmtcFmOFBnCB?=
 =?us-ascii?Q?30C7w3OT9TVz39cedEojJGXLW+bVO8UnbceXOZSD3L/ACI/y7SopvnuLaY8K?=
 =?us-ascii?Q?GTjCdvQEeL4Jldx9G41GhX9YJXpmwYFdlQjp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7gM1DpU9ounvl2WELS3zMCUnQtuxccyxiQPilEc8v1h0Xo+HaZRB6YoTZsGl?=
 =?us-ascii?Q?frQeX5qDISM9f3QiNDXhGlaXpyL97OwVCaLlkVUrQ4hdaMq+nH6mOghynX0K?=
 =?us-ascii?Q?yk1BIF22d/qkzVTJV9Dtj9zg9oSEAh8Bn9oqr3SAcYfKAKdmiN33oCBr/3gi?=
 =?us-ascii?Q?8IaewBNP4KpYMlPUyrsfd9DL/PS631m6miLRUdxnEnFn/mS94d30wb9Fjgkb?=
 =?us-ascii?Q?0SqitpDWen5Jh0Gk1oW6pSt47jle8ghIO04ImDnZkG6hdhWXTaHgrD0kx32D?=
 =?us-ascii?Q?AoBhP/c7QzTvruYSpVAI/w5gYHw9wJxil12vEJF1OCv9cdkQBv7+b8w3aJEF?=
 =?us-ascii?Q?kf/fK6k34Ew3QasyMvpeqiUKfq+VZg4v+A+sUQvllZCP4lhhvx2Ld/l3wP61?=
 =?us-ascii?Q?J/h0DPd1dfiXfxWAk9rxMqNjTS8+o754JRsFV9c6vKfmg9tozOwZBSfGlITF?=
 =?us-ascii?Q?s21InQnr6N/tFURRMIry42qMJkUwzLBRD9d5/A6Lu432o7heW3t6AVdMytjb?=
 =?us-ascii?Q?Pr6YJiQ/dXgpYJdBJdQlMg7t7yzQHH86dNN8MWGWtRP6FqSIhsrU6wegR3cV?=
 =?us-ascii?Q?n1jFmkTVWHp4t1Olk5RFJVhq69BhDVFU2uDKrO4B+1IRCP3T89obVFkN3j3W?=
 =?us-ascii?Q?aDgkHIW/w99tWwPlpSkbmRITCQ4pWGbZ8Rl1HQTxOHRCN4df8zVySjwXyTql?=
 =?us-ascii?Q?zb1plj96vqUB/HhoIL4+eGVtbv1BpEOQKKKQBdf/SCGtM8qzXmb8fPB1FUW7?=
 =?us-ascii?Q?82d6BoBTVoFy6WlyblHsiBDr+kexizifu2JwGGT81/YRNdAWCaKkV6Qkx/PE?=
 =?us-ascii?Q?cJndKSO4GRWtqRhjJGGYkjvd9BBqhjriXZOpI9XX9YBGNySvQu8NskcPXv2Y?=
 =?us-ascii?Q?2DlqFuCwb1kCMUQ4hI3h0MN6rQKJQPvcBIYT0rfXXFANjY0tnx0J+Cw/gfLx?=
 =?us-ascii?Q?yhwRVymxpGLvZ8mEENJS7s5GkvHkYllcR9vbb6woJZKSOaSAs5NyzvIyqnk2?=
 =?us-ascii?Q?kkdTNyVhM8b/YCiPBo61DBFYxdOJ9+LHwJP8n18RzMF0wXRjBVNvO2zaAjJF?=
 =?us-ascii?Q?oDc/ThCMlEFvuNNJe+Q5bKhKv9FMatQOsgV9LQF16Tcg5A3AsMzEqAta5ft/?=
 =?us-ascii?Q?ISM1gz2jSSpa9Seap7gF7yteTy6Ql5XLlb2a1lG2txMoCH2YfG9h6z42EsYH?=
 =?us-ascii?Q?xlJvXUEH6XoSn1mucLPKsVFLO5neEbU9jkNY4PCq0fZhmwuoxqKBZ3VjOc5w?=
 =?us-ascii?Q?zIcB+cetAJgwJzgHpZq2Yu6oIQ5J/QPdZgeOpb5IZdTPxeXrc9h2v/3aHN+D?=
 =?us-ascii?Q?J/MDMGSMKybqfIpph5XExJh64vL5bR/9H58sJ18l+Gc4m2+/GeaxoXiTLMH1?=
 =?us-ascii?Q?MNBsv7UU4qwMrHHOzgycPcSUuzRQrRQTocoG/zFeXDU7tUz0dvAm0NkVVSLT?=
 =?us-ascii?Q?URt17kbTgQmfv6aMNAAnJZ5E6T7kftk9qSgA31jjrixSNerpQmXQNdDcolm9?=
 =?us-ascii?Q?oejwBUdmuaj59S6YJMUf/+DGvM2EzFHMAUWFUKhQIC2iN8byZ7hePwK9Dr1K?=
 =?us-ascii?Q?c1Vrf0l4JVLjWPfqzrX+7ZNdObMmtqjOI78Am3VRcJJivkkVSMiJ8PVPgjBu?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 814d3a6a-ddb5-44f7-0944-08de0f59f47e
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2025 21:53:36.4636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkjmIEtvL49sIuerxT249ywSjDnGCaybBdyca3faicmnGHejLhoo/oigMa+CiHCj+iH4lmQS4oX27/DCaVJYNJIKS6Ioz5qoOofqYGGF+kY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8649

On Thu, Oct 16 2025, Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 16 Oct 2025 at 10:00, David Sterba <dsterba@suse.com> wrote:
>>
>> - reorder send context structure to avoid -Wflex-array-member-not-at-end
>>   warning
>
> Ok, I took a look because this sounded like a bad bug, but that flex
> array member really isn't a flex array at all.
>
> It's clearly intended to be a fixed-size inline array, just using a
> flex array for syntacting reasons.
>
[...]
>
> Sadly, I can't think of a way to have the compiler just calculate the
> right size at structure definition time without just having to repeat
> the whole structure definition twice.
>
> So that flex array may be the best approach even if it has these downsides.
>
> Does anybody know of some C language trick to get the remaining
> padding size without repeating the struct definition?
>
> "offsetof()" sadly does not work until the structure has been fully
> defined, so you can't use the "obvious" trick
>
>     char buffer[256 - offsetof(struct .., buffer)];
>

I think this has come up before [*]. Doesn't -fms-extensions allow one
to do

struct __fs_path {
	char *start;
	char *end;
        ...
};
static_assert(sizeof(struct __fs_path) < 256);
struct fs_path {
	struct __fs_path;
	char inline_buf[256 - sizeof(struct __fs_path)];
};

and access every member of fs_path as one used to? With the bonus that
it's a real array with known size.

Rasmus

[*]
https://lore.kernel.org/lkml/CAHk-=wh6Ra8=dBUTo1vKT5Wao1hFq3+2x1mDwmBcVx2Ahp_rag@mail.gmail.com/

