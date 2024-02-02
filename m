Return-Path: <linux-btrfs+bounces-2058-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D136A846B36
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 09:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B161C26E50
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 08:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA8F612DF;
	Fri,  2 Feb 2024 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oMDuDSB7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="frJcBFXo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E17182A7
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863739; cv=fail; b=pBaa2DFhG71mdqWu+EznlWdRsVmhhreO2EsYv46FVWuvRQQIULHmV2UjF0fel9W/ZAJSEr3wtaOw6rcDjBxWvRpdD4EZsaco0DCZ3x+mN3f5LDu0CaSwO6jpQrk1aV1WYWKUtdc6L8BKVpv5eKd3jleZRZZPbE4IPDvD1WzRUS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863739; c=relaxed/simple;
	bh=nZmZE5tt50q6c4usj1xrwQBGNqsdKpA2bHHpQkrpfck=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h3+r3LvsDp59tUMYRtehvUM2ZBmwiliTNh3NQIL/JSmE41qKkL1CWNr3aJVUI7hsahjALdc19AnsEUzyEcNKvSOO8LVBlgEnhRwGkHQmFD7uI4W1z5LrWBNakpBdFfgZq1JJ3bUQ6DtASEzSI/ecOF5Vb7lrPENGFfODPFx44Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oMDuDSB7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=frJcBFXo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4128SvZo007625;
	Fri, 2 Feb 2024 08:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=IsLBukQwHL/BUxjRehHFVtTj77CqeGgAJuFH/8nTKZs=;
 b=oMDuDSB7kgNT677F8qMIOoC6r8sWhKDgNNfYKby+058/Iz48wk27L1M19lmRK/oBYtfT
 nFNzdOdlParBIz+7FTp4CDKNI2e6O8qn/8hsfQJphCUXpkGl8qn4jFUsWzsEkvAfGVLN
 7CUNfbMllfJT5wy18AgvLjAVaoQKFTOx9+6q4Lx9JOogq2aSqQ8ti20h0aXn6ezhXppj
 px01hOu7EGhPfwq8MVa55Nl4L6qlPeBncryGgaB+ESmgqPtN0DrMd/muKoqnXRQDS+WO
 olzpo2jAYeQXjawztleOqthisGds+AtYfJVah7RtoDIGXkDgw3Bs8y0adroBCjAnGgxN rw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm46ybb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 08:48:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41281MWd028462;
	Fri, 2 Feb 2024 08:48:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9bt09v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 08:48:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAwKQ/NDTXzc2SbvXbkpfJaYNzCBrMRjhRfAwF2j7HmL8FCveo74lxd0qKsXptR8T1xHt9ut6RuU3m0m2W4HLzzfkpSDGVqr25JxMxI3NRJUQU72hD6DQnH9NAMlqX5nT2srrsnX2KUXKTfErS4YyuzUWjEqAquWwFFjmt/5hYrE3yZioAv1MZWmDK6qfszBiYElluwi3wNvuQhloBd/IUtCeT//tgyWlliDYd0H2g0yyoDJp0OWrzlVcL0X5qXWP///K6hixnoooHsY360wiyjUsmfbYH9zfGGoTGavXygXXo/sWolVX68SwjxBvLFpV4J0+L5KlY5DObzq9bd9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsLBukQwHL/BUxjRehHFVtTj77CqeGgAJuFH/8nTKZs=;
 b=HcBXLKtzwZkmFsZ3/nTdDev4ZuuWaTpuoaejwZ7qlfH1PxzDejG+KG1NsH3741x7eGejYw777QQEmxeUEoPanmW0SdDzJ+CBJp+IMQKut6vRaekSLHw9WqPVsOA5B4ZdvFRgLSZOM3JWbSH76HdhqI5jlMG2PbK1FueyC3Iat+guac4Z8iU9kgalJnQrGQmuARr2uZCiiQtwlg1Q4EYURV4+ZZhwPxz8SeoYxBdfOkQQGvZybCpCcnmRkgnyYIgool61niRanIL+f3/7DeY55AZaJM7mIxWu7Ojs/kBby/Ie3dt5eYIt6n3lE6AjmabdaqaAoR2EWdhacGtdeeCwKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsLBukQwHL/BUxjRehHFVtTj77CqeGgAJuFH/8nTKZs=;
 b=frJcBFXoQAohGwNk3BfTWlZbA1NoCtZbth2OLbUC4l2UkzvMfBA/CA8YzPwn5uj5HXnwDXd+nnO6kH4o/6ORVufBg+m6rMicFGDK6Sf6v9QfSNyfZtiHHY1HfWB2hcql9bXQgMVITaDuEprrkEOh2rIRckyVveCFmJa797a9w/4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5287.namprd10.prod.outlook.com (2603:10b6:408:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 08:48:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 08:48:46 +0000
Message-ID: <b95073b4-4b7d-40c0-8ed6-6def8abe4ca3@oracle.com>
Date: Fri, 2 Feb 2024 14:18:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs-progs: rescue: properly close the fs for
 clear-ino-cache
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1706827356.git.wqu@suse.com>
 <c413bdf50d585364d867192889a761d8785a0ed5.1706827356.git.wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c413bdf50d585364d867192889a761d8785a0ed5.1706827356.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: b8223c4b-28fc-44ef-07ea-08dc23cbc43c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cUAbO70h66IUnU3PgGKr91NMiVCTdEWuh7zuZSneSUZp7LuHyMhhzX1hldOhM7/LgIwu+KQqi3/F5nfq3fhFTe8+H6E8Iwk8u7zIKTQLf3cOmxSpZ7gW2ipdwAOlJHik3py50yz/kpOCaBFdlg54j7z8RxFUqy5xqEEyraGdsXmnrfBwYzJmizT7qMBqGjk5kmFf3F9hEF2wu24D5CHsZ0cXHkuh+Q8gqWLmAZ9XZv+/nqPgI6eAyNdo0N6Bszp/ezn7YXasB3mQb0hHYC6VJT4sxXbnQ2xqrk6fU6Oy4dc6qxm83PzvF/UI7PNyjOPCt8ZIPMoMc1bA3H72nu1P0OyjEyrAtjlCzRtoMJPlj6rv33CcjFGtbPLp9BqybuHgk1NrOVflx23Cg6KbuUA+qoqZh+nYx2B8mi0Nh9tsDMMOlYSXt/W1Ku4QHIrZfZd2KQ/p0CqDWM0Bn3KkuHRiX8xBR9l6sYDI/hDizHXzBF1+SYokkua8KwLE+lciLdgfXeAurNuf8ptWrrRDnjqjoa1vjKhWpCCTEWzSKcHvGtJaZorckchdcqcSw689XbxLNLgZVFf/NL58HOVvj07sgirAOKDrJ0nCHrYX0/Jwv6cbVzTONaSrJJtUZJ5+QG+X6B/NRlPu0inYdV3SvXak4Hmo2wtoPoll5KISB9AFkdZrQyujKxRZ2hjOWVN1awRv
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(26005)(2616005)(41300700001)(66476007)(316002)(36756003)(66556008)(478600001)(6506007)(6512007)(6486002)(83380400001)(53546011)(6666004)(38100700002)(66946007)(31696002)(4744005)(5660300002)(86362001)(44832011)(8676002)(8936002)(2906002)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WmFQamk0ZDNqSGhIdWhDOXNzWlhXQmZuRURLRjdzOVU0d211a2l6amMwV245?=
 =?utf-8?B?Z0d3M3d2dXlLcEl3U3EzNjB3eVFxc2ZOVUlMSURYT24yWGNwTS9TWWdPdXI4?=
 =?utf-8?B?S2NFcjN3cWd1Rm5pdmxCOWkwUGI0VDJJQ2VqTEI5WGlNQzdRZC91NXk5UzM2?=
 =?utf-8?B?OE93Y1JuL1Rra2grSi9wVXQvSFJUWWZ3U1ZCdUFQbS9TcWhJUjlpaDRTVm9L?=
 =?utf-8?B?OU5HclEvbGcvZ0I3MGRpV1lGenR3bWY1Rm5nSmtEbXR3QUdYUmYxcGh4djJt?=
 =?utf-8?B?WU8xUlVaQkdTeCswRVBwSElvNUZ6MkV1cnlFc0NjZXRpblBuL1JxVkw0b0tP?=
 =?utf-8?B?VExtUElCYkdKcjJ5RzNWUzNEc0hmQ0E1S3RkV2VuT0tHTFVlWlVHekw3TnBu?=
 =?utf-8?B?RkRIU3MyUkx5YW1ydllRNUxrcEtQY1p1OE83Q1hCRFdWeGJleEI2aWFBWCsw?=
 =?utf-8?B?M3BNbkRHTmtiTHVLNG1RaGZ3cHVhK0tlRy9vMXJaMC9ucytsaVZNSGxnTGJr?=
 =?utf-8?B?Q1dNZmxxSDNnVW5XS2Q2MmpGaGx4NHgwY3Y1YjB0d2Z0MnRUeXVhK2FqQy9P?=
 =?utf-8?B?RXFhT2h6QmlmTDRCK2JjaHZ1VEp4RHRuVWw0Njl0d0dpS01pQUlIK3FpTEVD?=
 =?utf-8?B?UGlJVGxDUDVUaXFERW5RamtwNWFZMEZmaWtHK1NLcXo3S2xSQnVNUEwzcVBH?=
 =?utf-8?B?VjBKVVRwMWcraE5QYzNFenFzcnNMV0tSSTNaYVF6TU80LzFJT2crd2c4bmFw?=
 =?utf-8?B?UUcvQ1BKUDNMbVIxUUdaWm9YNHJ0NWovYk4rRllSWlpueHI3YU5pMHRhSXdR?=
 =?utf-8?B?UEhTdk1ucDIvT2FKVVZDaXkxdVVGLysvb1p5QXYwZ1ZCT2lnR1ErSzlRS0E5?=
 =?utf-8?B?dzFaMHBNeUtBVUFIVHQxUUxWKzRpVEtJMDNOc3k5YUU5ZFlNdHBEK2xMVEwr?=
 =?utf-8?B?dW5aUjkwUGFiUy9BSnZZVWU0ZXM4R29yS1ViV01TbVlYRjJmejJkb2oxNkdR?=
 =?utf-8?B?SjZNVGNiTGlHOC9YMUNKcnBjQWxaaXBlcFQxSmJMMnNYbVFhL01PeUJlMTl4?=
 =?utf-8?B?RFVhMG5UY3JIakVPdHZQcGQ0ZXBCZ21BZWJpY0t2Y0wxdmdRajVyWnAwTEg3?=
 =?utf-8?B?OWRxMmE2cGlwbHh6d3BmRmdxaWNPVFNTS3NRT1NjdjVUZjR4VVJ2S1J4V0wv?=
 =?utf-8?B?clVBR25Wd3VkalBSUk9EUUtDZEFTWkM5VldNTzQ0QU1KSmJJYncxVmg4WEJD?=
 =?utf-8?B?Mk9Za3VZNk5nMHFROGMrRnVibzlZK3FJem9BZXkxbklROTY5SUxEcCticnh5?=
 =?utf-8?B?dGFVSC94R2lRUmNXUlo1N0Y2TmxXSlNEcFdlTko2RDBiRkR6NmN5elJmV29N?=
 =?utf-8?B?WGVvZWtlOXdGbFhUMjc3OXA2dkZYcERwMklnbnBDclB6WkFXZ0h6SG1aTDR4?=
 =?utf-8?B?RkZmTi9KOThib1JxcGhGcm42TTZ1OUQ3bkx4OUF2OVdwcDdOZDBPTUVzMFNx?=
 =?utf-8?B?QklzWHFCSmpxZnp0Q08vNUllR01jVitrZzhlajVHYXpzd1VYK3Y4RFVGNzRx?=
 =?utf-8?B?cUVRbEYrK1dIdms4MytUNXVKdHM4b2x4S3hkQmc4SDBBNEFZQUlmaTBFOE15?=
 =?utf-8?B?bHpUa0VPNmdZdXErdlE0bzR0Q1V0WjhwOHkyNzVZRlV5MEJVYW5BMmk4bFFQ?=
 =?utf-8?B?Z0x5cFN5YVA5cE11cFI3cGR3eExOVktMcisyVWpVd1B1SHAvYzcwWWM2bXZm?=
 =?utf-8?B?MTYrRS9KbTdxYzdpOUsweUo3c0FwbUxuMEdlc3NKR1VuR3FhTFp5TGJmUlpN?=
 =?utf-8?B?dWZtTTV6SFVhYmlpNUZNVjE4cFRGQVZKOTFFcHg3aU50cXhxd2twcTRKV1dZ?=
 =?utf-8?B?MTFLeW1iMVFqZEM0TTNXU292dm1XSHpTamJPSjJzZzNnTDIzSjlrY2tMcmZq?=
 =?utf-8?B?VG0rdnY2eVE4OE5kVk5Idmltc1Q0amREdnMySk53SS8xTmpBdVhGQTR2QVNO?=
 =?utf-8?B?YXNMbTltWmlRZStob0EvWjZaN3Nyb2VtOHhqZFR2aWwvSkRoUDYxV2ZqY2Za?=
 =?utf-8?B?OGNKOTV2cURMaEwrZzRsMDIxTXVSQXNiSnZ3a1NzNktvSno4OHhaM0FLUGlv?=
 =?utf-8?Q?3LtpavDz267RymykHeWku8RLu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	965/s/38bWAmG1hNcH+lSrU6wNo4V3Z0GSYPGt1lTjcSNuyWwroVuiTefJrMft8L9LtbkZTFtl3Bh07spFchJ8AulmfPVoB/kve7NJOtqPfNhMvTh4iaC5cDWnWmKpYSXArB77Idscb+kRqn73GgIBayV1o+ry71L/QU6hCkg9BsIOWHpqFR1m4PEPxLgf7szIPAdwbt9Sk7KubiAGyHmRH+d1bzdo2g+zyr3L3AO5cIUuDM0ejUxBq7Ww4nYiBjcACc8ey/gCYarmPdB3OK/N+758cva8cl54cB9LHfU1Z2KrgtbfmBVx3QsdyCclOeemymrCf6bHkIV49ACWIht3OQSN4TEJ0JRislXTFQ6gOrpIeI3Sx1XFVAdsdJY+Ggx4G1jACqTAjJvGxexfIUkjySjuBe2ZFrwufO+bFyCqFNhZ5k7bJQ4RccKwBIZDGDYTT36kanNnEtOK2s7QCauoxZb2xsfCL0xnJJTcPkeuOfC19cwL93QVvE16PDDZI+vhfNz8yoRlA9nORK26NRESeO13YfDsCnjPJXcgOv2zy9U+XQn5H++A7VuJuLRLzDCV4MvF+Uws/wgl2CL1O1Qi8MUC2USogrhbDMeEqX92g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8223c4b-28fc-44ef-07ea-08dc23cbc43c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 08:48:46.0705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFqZe+u4CS3iXXWLao2yxdJH4eKT9GrTZAgFmElWPSxGrCRjg7gMmzPNOIw3AYk+d95sJFzizIl5MEbHUDc03Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020063
X-Proofpoint-GUID: US53K2Aretk0fAej0BtMf16l1OHFg8HR
X-Proofpoint-ORIG-GUID: US53K2Aretk0fAej0BtMf16l1OHFg8HR

On 2/2/24 06:29, Qu Wenruo wrote:
> [BUG]
> In cmd_rescue_clear_ino_cache(), we opened the fs, but without
> closing it using close_ctree().
> 
> [CAUSE]
> All my bad, I forgot it, as the original code is inside btrfs check, and
> had a "goto out_close;" to properly close the fs.

   Nit:
   Forgot to add commit id that missed this?

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx. Anand

> 
> [FIX]
> Manually call close_ctree() on the fs_info->tree_root.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   cmds/rescue.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/cmds/rescue.c b/cmds/rescue.c
> index 621e243b2073..6d7d526df145 100644
> --- a/cmds/rescue.c
> +++ b/cmds/rescue.c
> @@ -451,6 +451,7 @@ static int cmd_rescue_clear_ino_cache(const struct cmd_struct *cmd,
>   	} else {
>   		pr_verbose(LOG_DEFAULT, "Successfully cleared ino cache");
>   	}
> +	close_ctree(fs_info->tree_root);
>   out:
>   	return !!ret;
>   }


