Return-Path: <linux-btrfs+bounces-15832-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B3FB19CD0
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 09:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349DC1883DFE
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 07:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC6A23ABA7;
	Mon,  4 Aug 2025 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DjY4Jfps";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OMNljxoN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A41B23A9BE
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Aug 2025 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293207; cv=fail; b=VjX8GRDlsKKGufwny9yAuTYyz9G6J2uCGtv/dwCkzkGmkRMUidfxOQoSUOm0AJDR9cHmiiLfUQCEBunO3iG+CVhIE0iEqhKEc7NuBoT9e0KsvHYBifGNlxc+loLlehpauyohAWoLVRHcqj754GnMFTjyu+RKSno/h0fqOj7LYG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293207; c=relaxed/simple;
	bh=h8h5x9s4RdX4FXULx+IvC4l6OspuCDM/r0YhZ6nilhM=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=h72u6f1Of9du0ag79FsDCHF7KFk8tT5z8G2HXlaTPDDkkMua694RWGNvMOA88J9jVMHXytzxM1Xy8YnRF2UdnwzmQylTGMyOnwAgGdCz3+KJm3XeUrlnrL0gfQT/N3dlnBGWQUsuab9jbytckJV7/Fn6XN+Y094LVESRbyC6O38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DjY4Jfps; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OMNljxoN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5747RF47003879;
	Mon, 4 Aug 2025 07:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=P7mxT6QzDdfgXkl2d7y4d7A8RhK+dEckbJDdn/xuR6k=; b=
	DjY4JfpsCvuD8Zunx8m/8nqOKClleGnLQilbRbhsqWHOjkLuuv19H/id3U+WwkN5
	+PK1aYvaY4YLMhJu+GUlb2RrMN/wCUywA3xrf6P7xPML9gQIvLx4MKHrh265/x1/
	V6PHs0/jyWNAwrmIyjWQ961Pb4K+CDn2dnhxigJjfDSp96cq1k7JLG66+e+2UMP5
	38Xd7N3xDFGht5P95JuZscjkeZr1IPGDIl5VCJVBtrBlr64CcH3WQBSrpvzDgSkG
	2g1eRNrzKccIl98dlxNQDblrETjK6yX7sMSmzdXExrQJouW4ufZ3yRxdnpEutwR8
	VibxtnugtbBhWqN1XnrJVQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48993ft1jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 07:40:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57467ItU025374;
	Mon, 4 Aug 2025 07:40:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48a7js2a6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 07:40:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsHVWU5KY9mLO8unuvx+YReCZSueJKr6iLIYhtFMpk2raPWejajuUVKKw3v60hN6p8PjlXQN6XaNZHoXBB0ZeQ6nW8VVFhiNvoFBETBXToTRFpY1h9VCl+gk34cnANWPJ8uO3zD+fDUpMvDUAU6vxJ9nlwwfPWHZbW5eAep+GQzhzHxpPBtlzyGpAhr+mY4IWjDuoAPzDjyrY/p9bvB2u2gC1BiQokqkrifE41uJnE/9C3x65v5gGmYwdM0OFW3wdS0OD+prVUKeHWaRAy1JDITOq2YXBoY1EMrJW75mMOc6TWqApxreiB9+orljl7H2Lb92cwlwocKm3YLT6hAhTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7mxT6QzDdfgXkl2d7y4d7A8RhK+dEckbJDdn/xuR6k=;
 b=srbA2BSxFbw8u00k6UgyVJZtSb9Tn+BWFicmduTr+184LmGVlVVDNnWofv42PnGJjViheqqs429uD9qUoYM3tjzAudrBt4dQmPao7c7G4f6Os4VoL0nPIwDkHbWOJk7RSCtoqmkQCxNG3TrmleLY9/j1wc6ZH5dftAHttMIB3aRX51ciIH9sH/3EfMnb9PgrrhQjXLn6ehQsV36NiOVx+MahHsEm75Qil0jjRRbZH22vmCsp4JJU27/HFZ4QyAxsciWYO75N0uyQS/opX7otwzOjGcqfFc7YnjHVAoB1aqbia3+qqyFggJ5S44MULu7tsrH5C6vJZRujX8ewdzNQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7mxT6QzDdfgXkl2d7y4d7A8RhK+dEckbJDdn/xuR6k=;
 b=OMNljxoNWNKi+s9Z0FJ54Jn+nhUAfOkRQfGsKN5xbH1te4tkUBKQGwbHC5dvCBhMoKXmyTgngrLyz+LGKxIQdW+0KOP11ahiGhJfNTw4NhucHiul9x0QUudva7u6+ZhFYO6VA+CF2odfTelHVZmrIzEJNCQx1n/ZLQPoLNGyj1s=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 DM3PPFC190398CC.namprd10.prod.outlook.com (2603:10b6:f:fc00::c48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 07:39:58 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 07:39:58 +0000
Message-ID: <8daff5f7-c8e8-4e74-a56c-3d161d3bda1f@oracle.com>
Date: Mon, 4 Aug 2025 15:39:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Should seed device be allowed to be mounted multiple times?
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.de>, linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <aef03da8-853a-4c9f-b77b-30cf050ec1a5@suse.de>
 <4cdf6f5c-41e8-4943-9c8b-794e04aa47c5@suse.de>
From: Anand Jain <anand.jain@oracle.com>
Cc: anand.jain@oracle.com
In-Reply-To: <4cdf6f5c-41e8-4943-9c8b-794e04aa47c5@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::12) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|DM3PPFC190398CC:EE_
X-MS-Office365-Filtering-Correlation-Id: c84a3d72-bc62-4e32-3391-08ddd32a1caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NngxaWdMZitpQy9BSEZMOGwzMlZMVTd5aU16Rms2a0o1eTF6N05ISjNKSUhq?=
 =?utf-8?B?NVVXR2J3WDJXRzhabXQ2U2tPRW9uM1ErUlAvRWlZaXJwV3BpUzQ3OWZScEFx?=
 =?utf-8?B?TGRZTXNSY0tVVHpyajlRQUN5QktoQWRtMlV1OHk2NUR5RGJTM200dHllK2Zy?=
 =?utf-8?B?MHA4MXRhUVdhWHQwNTVabTZWYlk1dlcvMjFQejk3eFZ1d1JnVXVGOUNUaytV?=
 =?utf-8?B?VFJpUTIyUis4QzAxMWY4bHJIR2dDdG03cCt3Yjl4cGZPYmRlODJqbURTQ2Zm?=
 =?utf-8?B?SS9IVDNKaHRJRjhvbjdpUXlCUlZ5QVA1YmY2TW1VUlBqRjIyNHhvd2JXT0tr?=
 =?utf-8?B?RjlZMFNoVjdDY05RZG5xWHlJb3Nwd3JHYUNmSThDT0wreE51enlQa3BvWkxr?=
 =?utf-8?B?OGZDNG9wUzh0b3pxTTlDSFB4K1ZaaitEQ3pidE1WOVFwc3VId21vN1I1cm9G?=
 =?utf-8?B?alJFdHg3MUVyL0UvVUtHTlU1UE1uMllxWkV3d2F4SGFHU296cEtYVGNEblQx?=
 =?utf-8?B?eEtlYzZSUC9lRjVqbW02TzlaZzVoclVNWmZ4MXo3am5BUFRvTEVpSk1HczB3?=
 =?utf-8?B?VTQvTldpRGsrZUlqRjhYajdOS3JFbUxmTDFqMUZRallld2FTMkMzUmk0cytD?=
 =?utf-8?B?aWhKeDhVcTN6L0FWWWNGdnRzdzRXSTZQTXVZZnl1QUJYdkJXUHZTczlSZjRk?=
 =?utf-8?B?clFJVlE3ajRUalBaOW1uZU5SKzNobDB3OExwZ2JXVkYra1kycUV6UXlQSk9S?=
 =?utf-8?B?ejBIUWtVcjBtY1pBcEVYSkpBcDIzdmZObFd3UmtvRktvN3hXbVpvRnAwdXFG?=
 =?utf-8?B?aEUxcjBsaTMvRVpHSjBjSDlUWHNkb0ZEMGVRMWdKQXBaTmRIZlQ0T0FwbE5O?=
 =?utf-8?B?N2dZV0p0L2NLME1ESjRsNEkvekJ2Z3hiaUhIejlIb0RVMEsxQ2h2NGcvSW1n?=
 =?utf-8?B?d1B1RWhUeFd5MWZNa1pLNHBpMHo3TlhzNlM2NnEvbnBtdlY4QnFhZjNoeStx?=
 =?utf-8?B?c0JQZDNocEd1VnptemdkL0Z3a2JRdWVmU2Q4ZjNNUVJJNHI2TnZIUHcza2tp?=
 =?utf-8?B?Uy9zOFRIcWt0ZENhU1h0OTFrVXhKS3VTalRrY1F4SmtMN1JTM1RoWG9KOGdR?=
 =?utf-8?B?blFEYXFSdjFOS0tkOTQrUVFXZFgvREZwOU0vTWRXVTg5VWNDRXhESE5YbVJL?=
 =?utf-8?B?TlBZU1cyalVvTnZZYytxL2JDbFAvZ1E3eFRPSTBhbm5WbHpzNitKUFQrakZu?=
 =?utf-8?B?cGo5aXJadmkxdkZ6LzZzbVhmc0FHaTdYV3J0WURPaEluUFJ0ai9mQ0wrODdB?=
 =?utf-8?B?eWs1Q3VWNkswbWQ3a1JCQ1FvS0VvcFZyRm9WamRjczc1OGs2YjVuSnZnckVy?=
 =?utf-8?B?eTFLMWdwbHlOSlB0dVBTZmZoRGpwU2ZpMUVEZHB1QkJWeFU4aldxa21CMjAz?=
 =?utf-8?B?bERmVzRIK2N5bHlRcENoeHJ6ek5acG96MS9zQzJtT0tUbTdiL2kvd0xHSHZO?=
 =?utf-8?B?WUMySkh3YmQrUEI2dEJqMUMrZXBJZTlaZzhsUlIzS0ZlSVF5M1liQmRBWTRo?=
 =?utf-8?B?YVZkdGIxa2tGVEtBdEhjUVk2MmJ6QThsajBoeG9ETzhCSzdoYmxiWFN4UEhu?=
 =?utf-8?B?K0IyVkNyT2hnTThNci9BZERtQmJhYk8wbEEzSHRUTUZnRk1udnVCdEdRTElN?=
 =?utf-8?B?cDBHTGZjVFNXRG4xaTFTVzQ1RnBRUS80U3NjbEJZSlp1MUs5REhnOENWTEdC?=
 =?utf-8?B?M1hTRTRINkhRMnRwdHd2TjBGUVJaN01hZHBpazhtTU51dnZsMllBRDRGUWxQ?=
 =?utf-8?B?ZEVpem9iYWZRci8vdDBvdytVUlRZbGkwbjRHcUhJYzB3cy9OMjVtSDh2cnNK?=
 =?utf-8?B?eURlN0J1Zm93OGZXZWlCbEVsQWtYTC8reFNwblNQWWJjZXZNc0dSVnhuZGMw?=
 =?utf-8?Q?oS7rP7P3CTg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0ViZzFMaSs5WVdUeDh1dzE4YzFsN2dVa1hWQWVZMnl6VDFFSmltdWltVkhu?=
 =?utf-8?B?c1drUWJ6ekZuanZoYTlXT1AybXFhM1Bqc08zS3BiLzloam5nbklOS2lWMmdo?=
 =?utf-8?B?SzQ5bDA1MEFXOFNpbTlZWEZTT0xETitPbitRM2V1KzlkTllyRFBHb2llWThN?=
 =?utf-8?B?Q0R5YTdJYUczcmpUS3hEZDF3eDR4LzZsZUs0SEtIOEc2d1ZYa2cybUZ4SjAw?=
 =?utf-8?B?WFgrbW5NTWhvMEoxYWh5UlRkbWdlbUhrTkhMQWFsMmNMNU94YVNEZzA0Z3py?=
 =?utf-8?B?Uk56aG9ZdEZOcGEvaFpWTWNtdy9XclVaQWlHYk92T0l6Tmo1QlU5T3MrUksz?=
 =?utf-8?B?K0NkTG40V1pGY2VPcWhLOG0yKytMTllDbS9TUlhiSHljbHZHOTlMQ2tsNS9B?=
 =?utf-8?B?SlNZK2xGbmhOYXZacUczYlRXRmUyY1ZjaFpNRFgrblg3b0VVRjJzeUIvcE9T?=
 =?utf-8?B?TWI4TVFPN0FYczRINSsxUC9zS1VWR25oU1IrbXFlUnoxQjN2RUlYZ1RPcmRX?=
 =?utf-8?B?Q04xYktvenZaOWRTOHVMakZWWU9Cb2lNMWtkMnFxUGZHdGEveHU1WHFKWDNM?=
 =?utf-8?B?OGtheHJ1MVdrT1pUeXBlNVp4K2xKTU9xVWxuVGJZSUZBMm11VEJQaXVFSVVx?=
 =?utf-8?B?a20xVWkweHVrMVBBV0JzM0NYNENNWlpyaC9hQ2pKOEZRLzBGQ1cxRWxXQk8y?=
 =?utf-8?B?YU4wZE1TWGJNY2VPNUlJRTNnQUdFemE3TW5BYUJaZmRSbk9KbVRNWjhGMk43?=
 =?utf-8?B?Z2piM1dIbHhVSW5nYmtJclhXYW1RaW1MTXUvc1dhWFlsa2tURHJiZ1NRdHNw?=
 =?utf-8?B?aGJMZzN6d3FOM3NOVnVmNzVkVmpaNHhnZm9LM2dLOTJHcjN6OHVJTlQ4cUVY?=
 =?utf-8?B?cjZERHA3RUZoVnBuOGNZZFNRRElmUmNxM2hsWFZpQVpnY0JyQ0VacjVlRUxI?=
 =?utf-8?B?eXppOFRKc2tnZVdMWXI1Vk9VUU5sck9USnhDMUhSNHJGS2ZtSStZUjhvd2FT?=
 =?utf-8?B?UGViRVg0UDIwbWdrUUljcE1OUTc3U250ZzdHWW1mR3BDSkVaZ2hIU2Y1eU9o?=
 =?utf-8?B?a2tOOG1tMUl3ckpRdWhRSElieVpiN2JpT2FlRExZYUFDVDg4NEZMeGE2MGZv?=
 =?utf-8?B?UU82MFprelgrRDBGdXlOVkxHM2c3T3dacW5vblRuWUhKV2dmZUFMSUczYjFr?=
 =?utf-8?B?cjUwQXBmWE1valNZemdpZmFCc05SeCt5SnJmd2QzclJMa1A4RmFIOWVwNElx?=
 =?utf-8?B?dGNMRE4rNENLM0YvVWpWRzR4UFlXMG55eXNzS2J6L0pUUnFiKy9lU2t0V2Zo?=
 =?utf-8?B?TlJtR2ZMcG9lbUVZeE1sbERGREJiV1kzY0czOVdoOWJFbHk1b3lXMFpVeHNl?=
 =?utf-8?B?cmlYd0VCOWNDVjhoYnVkeEpjU0h1VmlNYTJSaUFZeTA2ZnFwWDBhbHRGRDJK?=
 =?utf-8?B?UFp5S2lHUlU0UlJVZGpXWkptOEUyQXRQRVoyUUpiZnkrdWE2TmVtbUVRVGFT?=
 =?utf-8?B?b0tmK3BjVDFJSFRPM3krc0tlUkVwWmM4QTBackJoTXVmMU9wRW0wTEFEU2kx?=
 =?utf-8?B?UTJwYVpNbGVsRzVjTDN1Y25zb2p2eHJQQVJjZUR3YlR4b2RXVVdUbHlsQzcx?=
 =?utf-8?B?ZWNrZzQ2Q1VSQ3pqZUZGam1NQlUzaEJ2UzNJQkZ3YlAwZWJSQ2F4d28wbGhK?=
 =?utf-8?B?ci8zWG1GZzhQN3djUWVCWWlhWWZhZUROR05wWERhbURqNStoejE2VE9yaUpu?=
 =?utf-8?B?d1NkUm9hbDdvUGVkWU4rK2UwR2ZNSTNnRWUza1gyRWU3MzIxUDJ3aFNZb2pD?=
 =?utf-8?B?OFJQRzJuRmNoaHQ4RkJpQTRSSzJrUGRibi82ZjVLclBnRW1jWFNxRFJSSlZv?=
 =?utf-8?B?Um9EdEZ2QTVkd3dmQWFRTXJibnBTOUNLS1RkRzVOOHN6OStJS014ck9UR3U3?=
 =?utf-8?B?SEd3L0RoWjZjR1pXRHRKbm05bFRSNmYzdkNPODdkcklkQWp3Z0ZQUnZFSDlW?=
 =?utf-8?B?amJRamxrSUVseE5Mano5cFNBRXlPU0JBQjBiRFY1UFRMWnhDNS9wQ2l6Mndz?=
 =?utf-8?B?Yk8wYnF4RThwdGxNckpjNmhXRmlQM2NCUW50WjhuNjdDc0FGZllLN0Erb2xH?=
 =?utf-8?B?blo1OGxONkNSU3NyUGd1NVdMVGJOTG1RTk01YTZaL1cvQ2hHVWNaM3ZxRldl?=
 =?utf-8?B?MEVFd1ljZkhnQXBabVFpUEk3TC9SejdXSWFJWGsyb2V5SjFMK1JLcFBPcEpU?=
 =?utf-8?B?YUIwVkF2cHMwS2JSMGVUMisyMlJRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VDzLb/vnMOseTUSL4GrH/2qI6UbtgFsaJV4wJJ3+H7XY+MJd0IyB4u0n/PuuHmP6c3pdWAy3G54mo9PChm2qgpRciaBCHOU3mYUlqZ0gugxxGtlrDAva2QbGwdjH+g+FIkd9g+IB8rspAEP/BLZUq0De8C1Z5FtxipIaYoHYUfgbp48ZJ19iDpumOwcxtKj/5n4LbmpT7RTsKkwa9w22rKWWyIi6h4R9djvi/0vMyPFHSuAx7aZpzQiVxB2yQPd0jYaux1AzNkOvNxlt0LiaL0Hi1S/Mc/qI0nLH+eaZHJj98sI3RaiuUNkF19XX2UfzuJj5fzqKn/h5KirXOefSEJLF2b4j2rhHU8vW7AGqtNX5u03m+ZuNSjr9ZanWW7rOfSv+Jqq16cMHZXYhY97EIZm3FI/Ol7uYK0v1069JKa3C6ew4B8BvxBjbCMIwhRrIyKpXQI7vC/jIbMCYVyXCG7za/0dBoxaMgMWdwf/vce4yzVR/rsJGJe4cl3qNGvHFGV2RnEyIybO/Bk8GdA9dImQdmahPdZDTDNlNMuFYJ/M6BeSUBY7dK/CWOHm0TKQ8RYqTOKdW2geVHP8aKVKCsgSJscCYAJ5VDFhsCY7qUd0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84a3d72-bc62-4e32-3391-08ddd32a1caf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 07:39:58.4052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2llCOG9wip/oCUQ+e/HUjnuAS/OLVe802MANkLKYAdmz49uLuZpqOGp5F+FZDX3JjaleHti5qSqBvRWW/tJjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC190398CC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508040040
X-Proofpoint-ORIG-GUID: H6BwLUIPSerdEZr2XbsYMdyDaqCiBt87
X-Authority-Analysis: v=2.4 cv=bYxrUPPB c=1 sm=1 tr=0 ts=689063d1 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=h0s0oI24q0HVhJ_b:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=f5yhNhOQFUyYdj9jyiUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: H6BwLUIPSerdEZr2XbsYMdyDaqCiBt87
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA0MCBTYWx0ZWRfXwfvfKn32dNTj
 laT/gs2Emyp1kI1NlNq1ugM/37t9z0U+uZzUDw1pdKxZtlP7avzd/zT0VFBDun95mSVVFivirhL
 yMqbRasSBpbr3IN7hgkVsDN5X88FK8T92LzlaohK6wrPIq4IUV1tbtxvp6SXua8tNdy60V/NV8I
 gZOCbTs6+IGzdQ/9l6rlDslgx5FmoidyEUCwBsG+uWJF9Orl+7+jTowvoZvG0hnuYCcbOD+FLgd
 lYy6OwknxYZmQfqlowGN9PmtkP8bBeD9nzuua7dA16fm/Y6S4HsV/TlNtd9DekbL5jr11ML0H5K
 rASNkuNhGvxyBN42OAh/Kq+xlGXzfVegFE8c6RvrjFk+K0PyMUFiPzFKh7ptdOqBK5b6/bBCEQX
 r3PlsXzUJ9Vwei0Hx58QJzuZ1VP3fok3jwaipjfUaHb8braUGLHOxLjVRTUOdumgZgCxL1Eq



On 3/8/25 07:35, Qu Wenruo wrote:
> 
> 
> 在 2025/8/2 16:41, Qu Wenruo 写道:
>> Hi,
>>
>> There is the test case misc/046 from btrfs-progs, that the same seed 
>> device is mounted multiple times while a sprouted fs already being 
>> mounted.
>>
>> However after kernel commit e04bf5d6da76 ("btrfs: restrict writes to 
>> opened btrfs devices"), every device can only be opened once.
>>
>> Thus the same read-only seed device can not be mounted multiple times 
>> anymore.
>>
>> I'm wondering what is the proper way to handle it.
>>
>> Should we revert the patch and lose the extra protection, or change 
>> the docs to drop the "seed multiple filesystems, at the same time" part?
> 
> BTW, reverting will not be that simple anymore.
> 
> The problem is we're now using unique blk dev holder (super block) for 
> each filesystem.
> 
> Thus each block device can not have two different super blocks.
> 
> Thanks,
> Qu
> 
>>
>> Personally speaking, I'd prefer the latter solution for the sake of 
>> safety (no one can write our block devices when it's mounted).


This is expected to work- it's a key feature.
------------
$ mount /dev/sda /btrfs
mount: /btrfs: WARNING: source write-protected, mounted read-only.
$ btrfs dev add -f /dev/sdb /btrfs
$ mount -o remount,rw /btrfs


$ mount /dev/sda /btrfs1
mount: /btrfs1: /dev/sda already mounted or mount point busy.
        dmesg(1) may have more information after failed mount system call.

[130903.161395] BTRFS error: failed to open device for path /dev/sda 
with flags 0x23: -16

$ mount -o ro /dev/sda /btrfs1
mount: /btrfs1: /dev/sda already mounted or mount point busy.
        dmesg(1) may have more information after failed mount system call.

[130943.678745] BTRFS error: failed to open device for path /dev/sda 
with flags 0x21: -16
------------


One workaround is to mount all devices first, then add the sprout.
But that's not practical, as the full list of mount points may not be 
known ahead of time.

------------
$ mount /dev/sda /btrfs
mount: /btrfs: WARNING: source write-protected, mounted read-only.
$ mount /dev/sda /btrfs1
mount: /btrfs1: WARNING: source write-protected, mounted read-only.
$ btrfs dev add -f /dev/sdb /btrfs
$ mount -o remount,rw /btrfs
$ btrfs dev add -f /dev/sdc /btrfs1
$ mount -o remount,rw /btrfs1
---------------


BLK_OPEN_RESTRICT_WRITES appears to apply per block device or possibly
per FSID (I'm not sure).?

Since seed devices are read-only, a second read-only mount should have
been allowed.!!

After sprouting (device add), the FSID changes.
Looks like we need to inform the VFS of this update (guessing)?

Will work on a fix, appreciate the report.

Thanks.

PS:
I remember this (some other aswell) patch on the mailing list,
it went in pretty quickly (3 days).
I couldn’t keep up with the pace. I suggest 2 weeks sock time.


