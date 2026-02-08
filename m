Return-Path: <linux-btrfs+bounces-21507-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BsUIRD+iGkY0QQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21507-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 22:20:16 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B54D10A2CC
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 22:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFB6B3009B38
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 21:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CEF349AE7;
	Sun,  8 Feb 2026 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="IkQPietb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2C9346E7A
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770585609; cv=fail; b=rQL1DFVZ3o6g2Ji4txoTsU5LGT1cV3scPF4PoF/TpHPkici2wP9+VEG5VRdg+0n0S/jv6B7IwKHDTFOiAiKQeYjZTK/PIK21OoAnQxcY+9W2hsSuH1PD+1KqIpEdBTgpnJ//a/a8nt02d/boVOc3znDAyqmO71Kdm1EQApuH/YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770585609; c=relaxed/simple;
	bh=YbS41sjaBwB7/caQX+outwnHy6q+s4jfIhEiL/BfzaI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hdC39l3IixYHIt81lo07wwoLffLK7TCLSo2+Z0LbERr+1/RTOZArH8G1ZG89OK3iVKXeXFdvGgPNspQb+yAwgHWhWEdSh1FJtTPineQUSYiMxXniKf0wmw4FPa/Xwx4F1p78Pp97h/SgvQsaBJ4Ojp044mqIAcw079K/WpkDVVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=IkQPietb; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 618IW6Y0116848;
	Sun, 8 Feb 2026 13:20:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=KNN9nHY36hLpRNuu0k1kDBeTGvCaswX2VycpXPP20gw=; b=IkQPietbKutL
	ZVSnWS2v/tUyInXC4zUukXlPWJHsypIaYGi4SbEn8yFi7vGo1Q69c41VjL/stjDj
	kYu7Cg43V3ehCwCnURbd/0I7DX0lmy/jyfanvt5rgfXDfWzDhZWBBnh9lkLZQ49Z
	mNJHPIuQ5KE7aDWPMgcl8xC2SUBAnIF6bQWk4Qo1JEML4Rc8Ui9O8bT9atHYHWfO
	V3z2zqm4oFlEfs9avrEt+IOF4Pqe2VVDuVVwiLkRE9hNivk7yxg2jKRuedSeBNei
	yWOUOcXgfbJ0qNFuyAYjd8Ng827l1YE1ilGvOU5NSLuTtrRGazveQ/KVIsYPdfZq
	iPJww825Cw==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
	by m0089730.ppops.net (PPS) with ESMTPS id 4c6yuq1146-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 08 Feb 2026 13:20:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlL2NAUnL6UN+JgBzGRpbgI+g+30gTFnAnpiMFE3kjZ2dojrvjk6Mk5fo29g7Jcua3wtpqm02Y7JfW+Sr+lj2dX/8lgGB0u3VeHYPou5NlauEZpMtA6uYsROQJ708IvGd3VFpeRmfypQyHVER5bgou5uwlxFaB5OC7tlWF9rECTqXrwkWkcEdmisdKKn0gdK/kyXOQ4w4cJ/qW8ta2+/OXgDngtrI/S7DMiABthohLSzBv2mimFrVOGwLIC85wdk9HkX4SnqS8U2i7n4g3aHfH81ihgfbluFiUjr4LYf9Cd/ZXAkScuH802eAytszucF8Ww420yR7TwEEmCsMgCiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNN9nHY36hLpRNuu0k1kDBeTGvCaswX2VycpXPP20gw=;
 b=v6DUBtzDvi7I225J16lLq2jUP1lzv+89lC2m+tyAeA8oHGAnd3digW4vK4aCg7aWlvugis9EzxlJ2jCf1eob+KzUOQkBwvxjDJbu4yitQJgjbXTrY3QqbgVT9jYW96/N5ho38suOQTUqcSaUJ/hrTE95Mxt8Xmkn3igJ5kyLIZM91yfAyuwN7vyEY880mFcHa228lEhFfA4XswwCP1x6btWTW3U7GLnwvNp78FKaVIrxq7+vltDokpV3G0lVGvH6QWh5j65HuCCI3CRy90yzRTucdnCYC3mM6wRfSdzwj5k/oMYveC5f9AfXQCBCwkuNYzc+8bBEcTiNLgon2XkbjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SN7PR15MB5953.namprd15.prod.outlook.com (2603:10b6:806:2eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 21:20:04 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5%4]) with mapi id 15.20.9587.017; Sun, 8 Feb 2026
 21:20:04 +0000
Message-ID: <4d6de31c-7c26-4cda-ad11-a8418fb6d066@meta.com>
Date: Sun, 8 Feb 2026 16:19:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: reject single block sized compression early
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <89c6eb7756051dbe2e63693b5051394b16a9080b.1767667652.git.wqu@suse.com>
 <20260208183840.975975-1-clm@meta.com>
 <4cb38f95-6e02-42e5-9325-a5b4bd93d381@suse.com>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <4cb38f95-6e02-42e5-9325-a5b4bd93d381@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0039.namprd15.prod.outlook.com
 (2603:10b6:208:237::8) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SN7PR15MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 53daa611-22cf-4fdb-4dd3-08de6757d36d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eENCdWlzL2gwaXoyL25PYWk1V2cvUExhQWdiK3VpVjVIeTcrY0lxWnZWZk5X?=
 =?utf-8?B?TGdwcmpvRVRPbkVpQlY4YUFQREtJLzFlOS9QWjhQYUgxeC9nOVVyZC9XSWpO?=
 =?utf-8?B?Z3h6V2RyeGhMbm1KWmZKdGE5OUdQdEdIekNpaDlXMVk5bjZYYjlGK285V2Uw?=
 =?utf-8?B?S2RVa2QxM3BSNGNCaG02anJuVXpYaytRWnc3cC9mblBlOUl1TW9hbmtyTUF4?=
 =?utf-8?B?OHhDRWlDcmdZaTNNcGFnYVlDQWJ2b3phQjdPVDZmNnVNSWFSNDRsV0ZabnBi?=
 =?utf-8?B?STlxRDRwWTczeG1zZGl1RkZncXova2xhL1dyTlR4eEFWVVdxcllLSi90TzBh?=
 =?utf-8?B?VEhBYUFDNktpdnp4enpDR3BYMCt0L09jdGdycFRER3dDSlNjdW83VGJsdmx1?=
 =?utf-8?B?WFZiT1pIZzQvNHJwSVV1dU56TXo3RHc3czR1WTNycXRxYmc2ZmxvTlE2cTFF?=
 =?utf-8?B?R3lnblp3Q2g0dlNaOWdQdGFNdzgwVERNK3NLWHB4OHJQaFNIWlA5NUpNQ0xR?=
 =?utf-8?B?c3VXK1UyQkVoM2ZyM204ZDFVMzZPUnY4akdsZnZiOHVRQllibkRaWi8vRmN1?=
 =?utf-8?B?VnJ5b2w1b0FSUkdVVVF5Wkw5T3Z1NjZ3YnZLaVNPLzV5dGZpU3RRRVhwTi9i?=
 =?utf-8?B?Tk9ZSVhLbnQ5OCt1bEhJblgvKzhYUlQ5cFUxVVdjUUVhRU1JKytrdE5OVnp4?=
 =?utf-8?B?clFmSkVzY1g4QnI4RVJ2Wkx5S09qNmNhQXZLc01SSC8ySHo3NE5aYThzZ1dj?=
 =?utf-8?B?QUtIQ3pGTzlQckI3WFUzOXVFNFNZWVNEN01HSGUyVHhHVzZkczZwT3YvcXo2?=
 =?utf-8?B?SlYvQmZpYm1pUU9JSHBBdU5UMndLMUV0Rmtnc0lJdEJZQWNidzJJZHlkSVdx?=
 =?utf-8?B?UVFmOXhCVENyYjVuOXM3Z2w3SEtSRGxTSXMvOVIwclR6R1VveHdzQ0t6VEJw?=
 =?utf-8?B?Ny9Ca2dVaWtJenF2bUU3Q2FHV090bjVwSzRqOVZxbnJlR0NLVENqYkVEU2Fu?=
 =?utf-8?B?dFFjUW1iRjF1OWtVUjVGeVFwdVJDaFd2cndGcXg3d3BTYkMwemFrU2VoN2Nw?=
 =?utf-8?B?MkNvQ2cxOUVaV1VheGxONm9tbWhUVWpTbng3ckNYWUg4anBRVXJ1dFZvRnJh?=
 =?utf-8?B?dUdoL2NmYnloNmxraWxzQWVNb3hqQ1FocXNmMVQwSmxrdFFITVVhcmc0Mkhy?=
 =?utf-8?B?SkpnNi8vRUlxNklpaml0SXJQU0VNY0FnUlpjSVU3VnpmNFdzNTgwakhjL3RK?=
 =?utf-8?B?N3F2UVRvQVBKNmFJMGRSLzJJOEJmZ3ZTcnczN0lGSjFNWi9WNys5RzBSN0Yz?=
 =?utf-8?B?SGRNa25qbmtnZjEwSVBFMEJPL01zRC9rNy9hNlZITjA0b1djVEdIcytvaTB2?=
 =?utf-8?B?SU5jTG83TkVjdDgzZnFWcFQ1QWlpYzRUanR4UC9FR3A2T1JMSmdMTlFHVjRD?=
 =?utf-8?B?bnVMMndMRDkwMzV0aXd5V1NYQ3haTis4QTlHUGo1U0RtRk9xeEplS1EycHFB?=
 =?utf-8?B?a1ZJTTBxaVk4Ui9KZS9na2RjRHhCMTFYN21VV3RhV09BNG5KdWE3M2g5Slpk?=
 =?utf-8?B?OHdPblpSWkhHOUdDbVJOSzIwNFhEeVNsb0RVd1V3RHlYUm1mamlxL0NUdWNT?=
 =?utf-8?B?TVJGazRkWVNrREswMTEwalJJclBiOFNEVytqc1orZCtYd0pmbkhXYTBRekMz?=
 =?utf-8?B?Yk9HQTRVVXFYMlZTWXFnTHlLSWk1NDZaUzJveFpwbFNLNlo2THJTOVkrN0RP?=
 =?utf-8?B?OVQ1VHRUMHBZcXdlTVRrYWx5REtJMVp1Sml1SEhLaTArb3VXZmtCbnNsVUcx?=
 =?utf-8?B?bmVuMTFsWm4wc21FRkVOY3VsdUZ1WWZCeDllWnVuZXo2RzJJVExVR2FnTEF6?=
 =?utf-8?B?K0V2VHFvdVhZS3JUR3A3TGVMUVdQUnpnSktFRVBZWDcrN2x4cnM2WEwvdTlE?=
 =?utf-8?B?dUhZcVdHTG9RRVpqNzFMRFhjRnhQUzQ0UCs0OTlSK0VGT0tRQ0lOMXhLZElC?=
 =?utf-8?B?S2g3QmdSeXRmcjRNUUVxb01LMHFUbTNyUFk3cVhoWGpkNVUxbXVWbFpnbjAr?=
 =?utf-8?B?UEM2dmdYeDQ2Y0M2RmVUYnU0eFpUUmRtZXJnMXczNlhBZ1BSTEFURHJxZGpQ?=
 =?utf-8?Q?tnTg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUttSHZoY2tISDlNYXF5bWhDYWVzMmlqVGxyYWNvditOM1Z6c24xNytEMGZ6?=
 =?utf-8?B?MmdGSGNSVFYxZlJ1VnZYOWN2SEhTbnB1Q0REUE5YQUZ0Mlp2UVJWWGlQYTF0?=
 =?utf-8?B?TVZYWldpZUcvN3pqazY4bkZFd2JGMWlHYjYzKzFBMnFScDJxMTFvUTJNOWZ4?=
 =?utf-8?B?bTZzWXRYUlRkck5LOWpIT24zTHRzRTBEeVB2U2NCWWd5SEVONW1NZ2hJVWQ0?=
 =?utf-8?B?MmtMNW5oQXlXY3JmMklQZEFIcitwT3FqMFhpWC9LaUltc0h3SmRwbWdVZWpT?=
 =?utf-8?B?MFNHRVhtWTc4b2VnTFNIa1lNb3o5NzJVT2JDbG5vNS95MkF5THNrN2JYYkpu?=
 =?utf-8?B?cGJhQXdFNHZMZXZTeTVoMEdCeG1lOEI1Y3hWWVcySEZ1ODBGa3FTM1pnR01R?=
 =?utf-8?B?Umw1MTFJdTlkTjl4aVkxOE9aU3JDSVBYbUJhRWh1OVZERDhUaDdSWlFMcW0v?=
 =?utf-8?B?YkFnWHdheVl0eThpVmZMVXM2M05scDB1a29tVWNBVEtuMEJXZ01WYlVUeExW?=
 =?utf-8?B?d3pJZm9oMUlvSHRHckxRUmVZN0FxV3NDZ2RPNXlXQ1hETFU0bkpVaEQ5T2JM?=
 =?utf-8?B?NW9VYW5rRmhhbDdzMGF3Z3IzMnlwd2s5UGxGalBKZ2xscC9jczRRTTdVYTlT?=
 =?utf-8?B?bnV0eGVSM3dRYlR1TW5meS9teU9EZWNMMHM3L1UzMVZBYnpRWFZXbytFTnRa?=
 =?utf-8?B?eDRGejBzaTljYmhhbDNHNmttaEpYV0NrbGdmZXlEeVRPU1BveWtoMG1jb2Uz?=
 =?utf-8?B?YTBza25GeEdTUjJZeUU0TEJaNXFlMml4SDVCY0F4UElRdVgyUGpTdWg2b1ln?=
 =?utf-8?B?THVoS213d0JaQWJycUs0UnNmYzBCNjFLdzJXWkkwck1Zcyt5Ry9DMWRSdGov?=
 =?utf-8?B?WEZ5T2E0Tnp1U3pYTVd1Z1FEbHFrbWQ1NWs2eHJsNW9zaU1KME0vKzBHU2FJ?=
 =?utf-8?B?YUZmT00rNWhJbWNQWWxHcTlZU1FxN2lCTXJFOGdGNW4wNFExZVYwTGFEa25r?=
 =?utf-8?B?ZzdDZWkvRFlPOXJnb1V3MVNMTWF0dEFRK3NMRmhLc0NORERuVDFsczBaeU42?=
 =?utf-8?B?TWIvS3Z3eDBRSEtueE5wWEdqbHYwZjV3RlZlUFAvbkloNjF4RGxqTzdQSXN2?=
 =?utf-8?B?TGtub21iZkw4SEFiQ2tUVmhZeGErUUNydlJ2bVlOVzdYOXZUYUxvYWhPVjRK?=
 =?utf-8?B?TXU5ait2dGw4ak53bktES3JBd1Fta015NHR5K2tnMVhRbWtBM3VtM2tHNFpq?=
 =?utf-8?B?MC9OSHpaTlFrVFQ3Smc1c1dQTnNPYWJXMTF3QVNmalFiMEYrbndCbHR5SFZy?=
 =?utf-8?B?TlhoNTJtUG5MbG4wQk4zUUs0a0Q3R1RHVU55eEZ4dDNEdGp1aDBKM2thYXpp?=
 =?utf-8?B?M2hJRldxNWVhSkhzTWtTNXNpRm42T3liSWk4R20wYjRQUzVJNkord1hwdW1r?=
 =?utf-8?B?cG1tWWhnSVlnb2Vhb2Z0ZCs5YldSSUI2M3pOVkVhUTBzTUZxYWRZcU1CbitX?=
 =?utf-8?B?b2c3Z1pvdTZ5WVhpZTJDc0d5RVIzS1llV0R1eHhEbDhJRXRyR1pZZFpRL2dF?=
 =?utf-8?B?QTN1ZnJOUy9paE8zVU1obVZjY2FUYW44RVdqQ0xjblBkaWlYYy9UVVJmNW1v?=
 =?utf-8?B?SE1lRjg2YTJ6Wnp2bkpZVDR5ZHdJVmNXM0hheWdmcFd2Si8vV2RiNlg5U2JQ?=
 =?utf-8?B?c3ZIUDRGM3NTSTV5V2JMY1BzSVpDcDc0L095djBiVGhVWDBUOVhtRXllckFM?=
 =?utf-8?B?QTFaNGV6dHdLa3BXNXpXOUhndm03ekpEY1NkZEdOS0pCMGtBZjROL0JnTEtz?=
 =?utf-8?B?Nm9NYjVWQ2tUdmFxbW1sUUhlTXBVSGF4Um0vMEc2TlpsYUpwbmNuNGRBTERs?=
 =?utf-8?B?LzhVS2hTc1BiaWp2MmxQTERqdm1zSmpiNjVwOGFtc0FUVXdKMnJObmNLZ1hF?=
 =?utf-8?B?elIxN1VabzZDNW4zbHhpeUhpSDJxbTlIMy9jd2RVclFTcVExZDZ3bVRNaHNl?=
 =?utf-8?B?R2c1K3VBT3gySStsaHhOVSthQ3dPM1hxUUViNkhNY1pmMlJCUUl1ZkJTZHBu?=
 =?utf-8?B?Ymg2TDljbGphSDA0T0xNSkNMN0F6MkFxNG5aRWZZUDFsRUFNQURSSU9mRlRI?=
 =?utf-8?B?TlVBb29adU1JU3RtU2pJY2lFZytjVlVBSEJZYVRmSFdEdk1CZC9oQkRUb3BQ?=
 =?utf-8?B?Y3M0R3M2NTI3ZVVoNkU4bHZ0SFFpRWRmSHNVM2pFcm1PUFlzS2h2U1k2SCtX?=
 =?utf-8?B?clVJbHg1RGxKK0o2QUhXa25KbzlnTXgyaXF1MmhtckZ6WnBMYi82U0VuZ21t?=
 =?utf-8?Q?sMQBkt0a2k+NsUv+4Y?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53daa611-22cf-4fdb-4dd3-08de6757d36d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 21:20:04.1850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQD+HBT6Oc2Vp5LZBnEQSU3/fxvrI0jrg8DbQ0hsKvF1Dm3qmSTcyvYMsmtcNmE4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB5953
X-Authority-Analysis: v=2.4 cv=WZUBqkhX c=1 sm=1 tr=0 ts=6988fe07 cx=c_pps
 a=zTxK1Vn4TPWW1Y7kXDJIYQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=5hWcl1ug_gS8kcTrXPIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: uKRTeFxR-MgaAYbg-Q_A4ITtCwP7bp8_
X-Proofpoint-GUID: uKRTeFxR-MgaAYbg-Q_A4ITtCwP7bp8_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDE4NCBTYWx0ZWRfX0qksMVfj82Zh
 3kUI4Frg3YiCM71HHhNSSTcisRIebwy3xwtW1ZoOrW67UI+VUmm9qHsiPUQpQHVG9kkcBbXS7aN
 VyIlKgJeDiaMnHx6Xv/viuOrjf4+SXrgDkv+1o4Ah8W2aAsUP5bI1U+Z2OsMDBJF8JVB0jk2YlW
 SjoBp2RQXWN99tfontTimCExc6orwXBvBTYxcOPmzO3XLqH0VOYBCbGcLxNIVNUfnPPQxhOrKKh
 LwTtQy4lA/Ekl41oaCYFGtBo4mOeew8xKsuOFaOWWoDw3/8tQV7ZZA8zp6+j8q82TuVru5vrcn4
 oOSznP1kV/ybsYpkXLi3/fWMFCl3rccxxhWxr6RBoud2LF+oO2HUvEVqo7MWo7dBehikeSbjy0I
 Tpo1sjWhepoAO7Z29zK0WTrjq23voWMSSsjIoRp4Ng445t4UD6G1KdFlQTUHbcj9G5QCx0akK3s
 RH7M1nzo/7GjUEqqlWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21507-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2B54D10A2CC
X-Rspamd-Action: no action



On 2/8/26 3:54 PM, Qu Wenruo wrote:
> 
> 
> 在 2026/2/9 05:04, Chris Mason 写道:
>> Qu Wenruo <wqu@suse.com> wrote:
>>> Currently for an inode that needs compression, even if there is a delalloc
>>> range that is single fs block sized and can not be inlined, we will
>>> still go through the compression path.
>>>
>>> Then inside compress_file_range(), we have one extra check to reject
>>> single block sized range, and fall back to regular uncompressed write.
>>>
>>> This rejection is in fact a little too late, we have already allocated
>>> memory to async_chunk, delayed the submission, just to fallback to the
>>> same uncompressed write.
>>>
>>> Change the behavior to reject such cases earlier at
>>> inode_need_compress(), so for such single block sized range we won't
>>> even bother trying to go through compress path.
>>>
>>> And since the inline small block check is inside inode_need_compress()
>>> and compress_file_range() also calls that function, we no longer need a
>>> dedicate check inside compress_file_range().
>>>
>>
>> Hi everyone,
>>
>> I'm running the btrfs for-next branch, along with the encryption patch set
>> through my AI review prompts:
>>
>> https://github.com/masoncl/review-prompts 
>>
>> I'm working on some btrfs specific instructions, but hopefully these reviews
>> are already useful.  I've kept the headers to make it easier to double check
>> that I'm actually replying to the right email, but please let me know if any
>> parts of this are incorrect:
>>
>> commit 59615e2c1f63dfd65f74c166e803873d3362e51a
>> Author: Qu Wenruo <wqu@suse.com>
>>
>> btrfs: reject single block sized compression early
>>
>> This commit moves single block size rejection earlier from
>> compress_file_range() to inode_need_compress() to avoid allocating
>> async_chunk memory for ranges that will not be compressed anyway.
>>
>> Link: https://git.kernel.org/linus/59615e2c1f63dfd65f74c166e803873d3362e51a 
>>
>>> diff --git fs/btrfs/inode.c fs/btrfs/inode.c
>>> index 247b373bf5cf0..be47aa58e944e 100644
>>> --- fs/btrfs/inode.c
>>> +++ fs/btrfs/inode.c
>>> @@ -816,6 +816,13 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
>>>   		return 0;
>>>   	}
>>>
>>> +	/*
>>> +	 * If the delalloc range is only one fs block and can not be inlined,
>>> +	 * do not even bother try compression, as there will be no space saving
>>> +	 * and will always fallback to regular write later.
>>> +	 */
>>> +	if (start != 0 && end + 1 - start <= fs_info->sectorsize)
>>> +		return 0;
>>
>> Is the early rejection check in inode_need_compress() missing the
>> 'end + 1 < inode->disk_i_size' condition from the original check?
>>
>> The old code in compress_file_range() rejected single-block ranges with:
>>
>>      if (total_compressed <= blocksize &&
>>         (start > 0 || end + 1 < inode->disk_i_size))
>>          goto cleanup_and_bail_uncompressed;
>>
>> The new check only tests 'start != 0' but doesn't check whether the write
>> reaches EOF. This means a single-block write at offset 0 that doesn't reach
>> EOF will now go through compression, inline attempt, and ratio checking in
>> compress_file_range() before being rejected, when the old code rejected it
>> immediately.
> 
> I think the change is just fine.
> 
> The point is, the rejection for that specific case happens at the same 
> timing, inside compress_file_range(), no matter if it's before or after 
> the patch.
> 
> The patch improves the checks for most single block writes by rejecting 
> them much earlier.
> 
> But for this particular fileoff 0 single block writes, we just go back 
> to the old timing inside compress_file_range(), aka falling back to the 
> old behavior.
> 
> So there is no extra lose, just a corner case where it still goes the 
> old path.

I almost didn't send this one because I do see your point.  But what do
we lose by moving the original test into the short circuit?  I don't see
why we'd want to do extra work when start == 0?

-chris


