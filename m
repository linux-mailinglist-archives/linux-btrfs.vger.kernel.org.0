Return-Path: <linux-btrfs+bounces-8924-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139F099DD12
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 06:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF511C21973
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 04:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810541714C9;
	Tue, 15 Oct 2024 04:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NdiUK2wQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v+77pydn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC0829B0
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 04:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728965092; cv=fail; b=crrP2F9Kx0MykmUfn8JFGLjIjodRKD435SSO0lfdRU8p+D+Fclt6fFOTnT3sDpRDO0AhBsOL/ce97VlgVFfAJe3sNIBx0VjRuAeNXByS+BP7tK59dE9fnIvnuWmT0Qy7GwOFDvpKwbiE2LTFhe8hrYsHC/lbMOzpDJHIYUuuA1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728965092; c=relaxed/simple;
	bh=WCc8rHivuoPAAZUj+0IK/qg5JRRbb93+i89ZLUoNHlk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZtgL3fnMLNdljzCOU4XRpd5TV5tsLAwTmN1PxwfhayPZ/BdEcZBXTeGPaNwqkS2X1wHEX+p41B7gDwZUbMR9/agDOWVfzGm1wX+bCRHRJ3KBYuEVVvFveZcAyAf9JRNKSfUWcs4ljhmZbGF61g7n/FLrVQLZNrQLO7wID1cIBm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NdiUK2wQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v+77pydn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F1BdCV023065;
	Tue, 15 Oct 2024 04:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IQcorucO8A6ApeGB6+OVqeIO6yGBWA0jZJ2S3L3I+Ig=; b=
	NdiUK2wQ6tiSQpQGop1fq4MW89D5G7ZiQqE8wzGZuR6h8UQfw/mgCSHLd0hR9q8p
	xXv4lYhtwnN2aHP8lFb/092pSSVm5iS41afkQ/ZRzc14ucwObZAnc++5s9wupsHL
	n+6hpmMZArIhnQhqDExLubmQyqURF9NlTlkBXvpEXg+niymzvIg1+AAjPXeZObno
	UUwk13hK2XeaD71B2yWJ55XzqytuwcUUCbuuC5MqksKpeQKhh/PPh921BAuSdmKC
	BKtCgJDtZ7rzszp4E5dB64hBzAr3dlqPk46xXvHlOe4wvVceBt/IcsDQc70Zrghd
	Lr87afMJi4SnmjqJKiUBZw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqsyp97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 04:04:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49F1O3w7026291;
	Tue, 15 Oct 2024 04:04:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj6vtmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 04:04:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXLmNux7SRxWiv2XoeiSZPdNDxM087w+7Qln9+HPMnjaNrzGcPtAmJtpLue5n7oy6Ln1Nx3yIQ1Gzj+OVLQW9HsA3ww2tsyQeJwqN2v+zVKSiwpMPvLG510Ciue0/CB+Knt7q52GbqrVNtW2LRQ5JQdaQfFjZmtLO5ayuz819fWVCiaFqV+jvM+dKnHfO6p3GrmqQt/KiqD9gxhuMan7dgbG7xkskF2xZA2oQb0oM90X/W+bdRk5k0JrtVzCHfCzunJabhLD49qGaaS9Mr5/A95KBKYh8vB8dREk/QKVS0MhApJwklb/JHKby+Ef7r2WdjE0wgW9SXiLYEp8vOSs+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQcorucO8A6ApeGB6+OVqeIO6yGBWA0jZJ2S3L3I+Ig=;
 b=vyEWMPWvSc/AQmiObcxCKurVriO/2bNkDAyUmyYEiGG4qWVA/JRjy4X0icV095cXnjvAb/iZ+K2SONgmABLHvhF9E5+IQOJihxROSr15j2UpEAnShSGKbWduNuLniVvvsaq5rlIeH0D5oqjgnbcQFDHkZ8H41rXOg472UIfhfLQw1MffmMbI+TyMi+8d8BJIWKiW41LzTtZ1msytEXuMrI08cjcUHe2cApw+qdqZKYy4sLGzzw8dnPm00a4cFW6ogaf45AQ3lhkhwImJrftE3uc+3EQjRjge2rkEUOmiOzFa1ybnigoEHZE/wW7jUzA5Al433XOP/JHv5ZXiS+kq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQcorucO8A6ApeGB6+OVqeIO6yGBWA0jZJ2S3L3I+Ig=;
 b=v+77pydn0zpg2aLZuypkUjck/nVD4bi/EnlhL8PDaU2Hdc8snSk0TSEdOLUpa9SpfGUu1rYsvjOQrYNgFxXyh1xiL5bPSemSwwW722JYDjq8ldVOYiG28yrDkP9VOVQNoD6DsqwFnqwnWSdk+0i9Fhk/qkqz2gLQO4SbJBJ9omg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6378.namprd10.prod.outlook.com (2603:10b6:510:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 04:04:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 04:04:40 +0000
Message-ID: <10f0899c-15d5-42fc-9d8a-ccbb573673b4@oracle.com>
Date: Tue, 15 Oct 2024 12:04:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use FGP_STABLE to wait for folio writeback
To: Qu Wenruo <wqu@suse.com>, dsterba@suse.cz,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <9b564309ec83dc89ffd90676e593f9d7ce24ae77.1728880585.git.wqu@suse.com>
 <20241014141622.GB1609@twin.jikos.cz>
 <8ef15f84-6523-4e47-beda-fa440128df0e@gmx.com>
 <20241015003148.GG1609@suse.cz>
 <3c6ce709-472a-4fbc-ad54-b7257c18c62d@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <3c6ce709-472a-4fbc-ad54-b7257c18c62d@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: efacdc1e-039e-4686-0ff3-08dcecce7e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1orNVZORjhsYThQZFFXNnVaVmNwa0hLem1kbUsrenltWFdJUHJ1NzUzQzJJ?=
 =?utf-8?B?QU1qbFNuR25HWXVaOFlwYXYwRXVXZ0RQYkV6dFAzSWQvQnhJVUxZWTVtelJz?=
 =?utf-8?B?MW51L1hKYmhmNXVNeHhxN1B6VW1NdWE4UzBqcHhORUlMSm5CcWtHcTJLN2ll?=
 =?utf-8?B?S0VGQTJZMFZwQnRkcnVXRHRzZlkxNXpOVWo2NU1ZbmlGZFdOWEVKMFRkSmEr?=
 =?utf-8?B?S0orajdrdENBaitSMWxGNU1qOVA0NmFhZ292TXl1UlVLWngvT3VWSzJkajNG?=
 =?utf-8?B?ZjZ6RXRKcmIycFFFWVZyZStXKzBJQlovdWFHYnE1Y0pmT0JWMTk5T0tnMXd2?=
 =?utf-8?B?UmwyR0k2TGdCL0YzcVVHMHBiZGQrd1hMVEF1VXBnNDdlYzRkbGlUaFY5TDlh?=
 =?utf-8?B?cGg4RW4xT1UvaTkzR1RhOFlTLzBUMElJT3Nsbk5PTGZFZVh0RlBkcXJWQXBB?=
 =?utf-8?B?ekY4OE1MWW1yNEpFbGdNbVhTZHFEM3J0eFdBRjJZdklnbnBQdDFZU1doSmdI?=
 =?utf-8?B?N25XTFZvcllRUmdZREVtWTdvRkJVN2dlVG5SNFd0RXAxVjB3cHo3MjFDUktT?=
 =?utf-8?B?UG1rNFhML3ROOHZmUW4rVjM0YkdkTmtzRnJBREt0UlAzd1ZQaEtwZ092ZEcy?=
 =?utf-8?B?VjB4UFNQRlI1VzBhL1NNbFpIbURYZFFpTytYYVdVRUNRRUU3U0d2L0dUK2lj?=
 =?utf-8?B?UGRkd0taek5lV0NLYVJuclI2SXFRR2d3OWRiYW1XQ0JqTG9FK2lTZDZtV3pV?=
 =?utf-8?B?VmZRQUhuYkVZd3FpZzFBWVR3aWo1K1RzazVKbzBjVDhZRGp0eXowaTJFZHpN?=
 =?utf-8?B?UCs4MU1qeEd3eEllYzdWVFJCeS9iZk1sV051RmFONXFGdTdSR3Z6cy9Idm1t?=
 =?utf-8?B?Q3o5RFQ1UHdocHg1WXU4bHZ4akpiRUF2K2lzOE9VMk5JZlMxRUZ5a2VEUFp6?=
 =?utf-8?B?UDhPMTFlNHBGTk1UMU5UeXJVQnJWNkJFR2JPMG1xV2hWZ1FzTWNidjluZU9i?=
 =?utf-8?B?OEp5dExWZ0FFdFJCY05tU0oxcnVjZTJRa0JWa2R6QlpWSDJlQWhJRHcwclJi?=
 =?utf-8?B?WGJvdUUwN2pRWm9DTmtPRVhDOXpSQ2hMRGFPQTFuMk1tVmVOdUdOZjFnenAr?=
 =?utf-8?B?WllsOWxZWjlQL3R0QmZMRmZNUEJZUzRiTHhOQXFFcU15MmQ3Um1Rd3Rzd3pD?=
 =?utf-8?B?Ny9Cb2xQdDBQMzVsS2tub0I1VW50Mm1lazR5blNHQ1p6QVJnWVZYMFJtL0pk?=
 =?utf-8?B?Nk1TRHhLdmQ2U2xoTVROODB5Nkx1TUdOWTF6MWxMSzY4VElDR0JMOHE1ZmtE?=
 =?utf-8?B?RmtrRUxOdTQzd01xNFlyL3g2K3B4ZUIvdGZkSHlORFB0Rzk5dy9jaG9KR3Z4?=
 =?utf-8?B?K0JJcTN0T3d2aWxUU0lnQ0JFMkEvT3lEdkZhdit6bzdTcTVheHpZb1hYUDVC?=
 =?utf-8?B?dnM5d1dUOXBZRGlEUXZLNXFmUXRVT2hOd0F1RmpmTXlteEpQMGxONXM2ZWdy?=
 =?utf-8?B?RXhaNisraUZQU2d3NVAreGF4T2RSbjFaVkI0RzdIWTkwN29jOHQ1ZlFRT2NJ?=
 =?utf-8?B?MHRwL2x2eTdsUFVrdEtuL05rRmFVeXZBYVVocEdOYTE3eHlCSllTNDhOd2lK?=
 =?utf-8?B?WndjUDh6NEVyanhYY0FQQlFtbWFWR1hrS2JGYys5UmxjR0cxWlF3bmJvVXRW?=
 =?utf-8?B?REtYRmhPcE1CUUtIK2xUZjZRNjlVdmNuVXpJcHlMQkJPUWtrMGNpZXdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cno3YXZ2S2hiUmpRdHNhTXo2N1YvTnNuQ0x3cllLVFNoZXd6Tk03NW80Wi94?=
 =?utf-8?B?Yng3VGdZYkxIY1k2VHU2R0ZnZXArVXQrSDRaTlluS3NZT0NvWjhKMW1oUVJk?=
 =?utf-8?B?WXgxUmZleFpjcFlmdmFRSE43NS9EMFdpQnliNjNKRDgzNk5LOVExT1BOdlhz?=
 =?utf-8?B?MXRrZzh5bHEwa01JS25pMS9UdFI2bk42aUdBd0Via0xNQm94QWtvZEpwc04x?=
 =?utf-8?B?UlRKZDR5aFdmSmhaUFNXVnVjYm9wUnZKbWMyM0pZM096WGpjQkZoaEtCemNo?=
 =?utf-8?B?QmRibjB3a0RjbTRwaWg5UzdXTEMrK0V6Z2ZNTHY1eEdWaXd3L0krVGl6Ym9p?=
 =?utf-8?B?aWREN2ZSTjhNVTliNmY2S2s0NWMrcER4UkpwdUw2WU9VOXYwV2VDakgyV0cz?=
 =?utf-8?B?WnFZZmJrazdKNjA3N1lNN1FlUEVzVU53VUtZa0JzYllhWlhqV1Q4NkpvdENs?=
 =?utf-8?B?Y2owdlN2WWtMVGkvRzNvVmloUmE3Y2xadWJtZmZvNnA2czA2aWoxbmhuOE1D?=
 =?utf-8?B?NkRZZWF1Y0tYM1M3RHltNWNiVXMySTN5TlNZTU81QXEzbmUxL00xb28xS2JY?=
 =?utf-8?B?OFdITEoxVS9pdi9IZWNuajRMTmdpcXc0NlM1OHR5UklzMmhKaCtiNURxVU1R?=
 =?utf-8?B?bU11b0FpeU52a2NYMFJVR0kxdGJLeHY5M3M5OW9DT2wydXd4NWZGZEQ1d1M1?=
 =?utf-8?B?NFYrRnl6bGRBRkgwVGpERFAvT0tLN0dWYktqMnU3Tlh4OGI5d2cya3lNWWcy?=
 =?utf-8?B?MzlHeWpESVVGcUxKRzRJekdrREpKSENPRGQzTEVxNVNFdXViQUhUaHFhcEIz?=
 =?utf-8?B?RXJVbytIekE1UytOa1pDcEdVbmsrOFM1QkNCT1J0YWFLWG1qbzFpQmNBNTFo?=
 =?utf-8?B?Z3VuNVMrdFVadFZnRk9abmNuam1lMmlxUHJaUjFIMVpZVDcyQVc0WkQ1YWNR?=
 =?utf-8?B?TGROS1RwUjVZS1RNcjRYL0FqaFFoVDRFUXlZK2YwWWtXaWFHOVZjZVZ5K0p2?=
 =?utf-8?B?VGxhMlFjSkswcVVjWVVWeHFabk8vSU51bG9DRGMxTzQ2Qy9aRkYwMU8wSGNt?=
 =?utf-8?B?VnRLclJXcnRueGtyQU1PMlFuQUZyMmlxb2lLVmtrRWZPbEdCY3NJN2JsLyt6?=
 =?utf-8?B?Q2szWTZWTWgrOVVZTG1yQ2xsb0RaUW5ieVA3MTJMMjk0TkJCeDM4WERCQ0lq?=
 =?utf-8?B?Zy82U3dQV1Y0TVUyR20xRldtQjIxMjNHaWhLclR1NkhqQXVxalArLzRNZTlz?=
 =?utf-8?B?VmdocFdleXh6WEtyZ3laSlZaVlA2NlRyNSt1NlRLSUxrTlB0T2I4dVpBYzFi?=
 =?utf-8?B?N0FobTI2RURIK3BDWFp6emp5RTRlMUdCOXVoOFVJMmh3T0dCZHp5V1FlQTJU?=
 =?utf-8?B?UHNUd2t0Wkc3a2NJcVB0MllGTWN6YTVVa2lLMjdvellCRTJlR1JicGpiY24z?=
 =?utf-8?B?RVpoY2MwTUliYlRHNmlNWjlISk00MUFSNXFTaGJOa1ZsVE9jT1JSdktOcXI5?=
 =?utf-8?B?M2hyOW9ZRWIzM05WS01hVWV6YzgzeG1tWHVxRkFvN3lsWDErL3NlVndtRUhI?=
 =?utf-8?B?bGhpN3BIYnpDclRHK1ZGMzBJM2VLNG0rOVl2WVZhWnM3bVg5dUFTS3FXd3FE?=
 =?utf-8?B?NjN6ZzZOZitaWVpNeDBiMmxuSHNyMHdUV2wxVVZaa2VETnprTFZMaUhVclpr?=
 =?utf-8?B?NXlwVFJIcWlZWnB3Y1RlQ3l5TW4yLzIvZ2VhSVhmZVF5QlJZWjhOZnB1bXJQ?=
 =?utf-8?B?RTlJSEdYdU5VN1ZUdHV3UTFFY1FWMFJpMVlQeWU0VjhRZGkvNmI5djVjV1Jh?=
 =?utf-8?B?YjJ3dGZzQ0pjWkswR2lxelRkTFlzRVFJaStnazdadTNFOFJsbVNGUEdkdUo2?=
 =?utf-8?B?VUcvYkNGekNTTlppVHhLejhPYTErOWxZelAzVU5peXZyWTlTeVByMndRaVRk?=
 =?utf-8?B?aENKcU1SUUJJK041OTQ2OGUrQk9rUUhUUU1WU0lBVlo5K1J6Lzc5WENqOWk1?=
 =?utf-8?B?eE5wREpsWnc5L1llWHdhbVJOTVhZeC9nRy94VXBEclI1RXdiZTh1ejFrNVls?=
 =?utf-8?B?K29kUDJoMm9uUWg5WU5FVldUL0ViemFYcjZQNGRxVEw2bFVWLzhzZmEwenhN?=
 =?utf-8?Q?fe5NyioOgku8sJMq2dswMrRxM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y6fn38RCZ7aqwflWxjmvPk7iWifGRROlT9pJA1u6QTmt4vxk5MCNGpo7a65NId+VVx40Ge93F6jp44ufhqmDqrlDowRANviRi1AwPaBEwMlC0aUS1NvIg6JBGB6BSFGwTWF8IGJkdzskfp/3dIsC3ByIAgyJVn5NQnIIQ9gsoZuRsb8DaomP49rFABEpybVNRr7LbZhmdWCvSuuSwAqX/IodyhaHkJDmYuVt1935uEpkjSJkyyRwp8ZxMAbtEBLdq2Tqa1JpnqHZ4NBcmB27TMvR/bgYSgB20pL2ZSX6PRasyfGDBVbxs3hl+CIns3gAp2yZeWEct2Z0ljqi8kAH7Svbc+6YViwNiRZJDWizDM8oBdz4aeJWrU46f+sL4hvjluxYZidMegKKtUC8sreqTfQlbQzb7lkveTGuM1T/GfI1pJMkgHdopWjW54dnQZFesq3+ZJ94xpU4iWdidRY7qUsgaU8rVOX1uQqRW20KerdaFqhoOrl8OeZ48XdDxin43MU+hy1tJvCRPuLajXjqu7fhBFB0j/BeLoql6jiSRaYkqUGf71gHKRSQnUBAXnMcJWZJ53TKAmDBtljGN/RW4/qJNusOFtBxcpU8MxULiCQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efacdc1e-039e-4686-0ff3-08dcecce7e3d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 04:04:40.7908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpro22xorNWcDG2Yn4Kdg+BjcZSpNprW5jAUKXRsdwqMJ4qxJ9Xk719qhY/s/9jMfQxATvD4eCP4YIp1JQIaAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6378
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_02,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150026
X-Proofpoint-GUID: cAdIRuqw9GqoAmXFP8YOEYS66XYUWYTD
X-Proofpoint-ORIG-GUID: cAdIRuqw9GqoAmXFP8YOEYS66XYUWYTD

On 15/10/24 09:26, Qu Wenruo wrote:
> 
> 
> 在 2024/10/15 11:01, David Sterba 写道:
>> On Tue, Oct 15, 2024 at 07:25:20AM +1030, Qu Wenruo wrote:
>>> 在 2024/10/15 00:46, David Sterba 写道:
>>>> On Mon, Oct 14, 2024 at 03:06:31PM +1030, Qu Wenruo wrote:
>>>>> __filemap_get_folio() provides the flag FGP_STABLE to wait for
>>>>> writeback.
>>>>>
>>>>> There are two call sites doing __filemap_get_folio() then
>>>>> folio_wait_writeback():
>>>>>
>>>>> - btrfs_truncate_block()
>>>>> - defrag_prepare_one_folio()
>>>>>
>>>>> We can directly utilize that flag instead of manually calling
>>>>> folio_wait_writeback().
>>>>
>>>> We can do that but I'm missing a justification for that. The explicit
>>>> writeback calls are done at a different points than what FGP_STABLE
>>>> does. So what's the difference?
>>>>
>>>
>>> TL;DR, it's not safe to read folio before waiting for writeback in 
>>> theory.
>>>
>>> There is a possible race, mostly related to my previous attempt of
>>> subpage partial uptodate support:
>>>
>>>                Thread A          |           Thread B
>>> -------------------------------+-----------------------------
>>> extent_writepage_io()          |
>>> |- submit_one_sector()         |
>>>     |- folio_set_writeback()     |
>>>        The folio is partial dirty|
>>>        and uninvolved sectors are|
>>>        not uptodate              |
>>>                                  | btrfs_truncate_block()
>>>                                  | |- btrfs_do_readpage()
>>>                                  |   |- submit_one_folio
>>>                                  |      This will read all sectors
>>>                                  |      from disk, but that writeback
>>>                                  |      sector is not yet finished
>>>
>>> In this case, we can read out garbage from disk, since the write is not
>>> yet finished.
>>>
>>> This is not yet possible, because we always read out the whole page so
>>> in that case thread B won't trigger a read.
>>>
>>> But this already shows the way we wait for writeback is not safe.
>>> And that's why no other filesystems manually wait for writeback after
>>> reading the folio.
>>>
>>> Thus I think doing FGP_STABLE is way more safer, and that's why all
>>> other fses are doing this way instead.
>>
>> I'm not disputing we need it and I may be missing something, what I
>> noticed in the patch is maybe a generic pattern, structure read at some
>> time and then synced/written, but there could be some change in
>> bettween.  One example is one you show (theoretically or not).
>>
>> The writeback is a kind of synchronization point, but also in parallel
>> with the data/metadata in page cache. If the state, regarding writeback,
>> is not safe and we can either get old data or could get partially synced
>> data (ie. ok in page cache but not regarding writeback) it is a
>> problematic pattern.
> 
> The writeback is a sync point, but it's more like an optimization to 
> reduce page lock contention.
> 

The commit/ref below avoids using %FGP_STABLE (and possibly
%FGP_WRITEBEGIN) in f2fs due to a potential deadlock in the
write-back code, but I'm unsure how. The reasoning isn't clear.
The two changes in our case aren't in the write-back path,
though. On the 2nd thought, any idea if a similar deadlock would
apply to our case in your pov?


Ref:
----
   commit dfd2e81d37e1 ("f2fs: Convert f2fs_write_begin() to use a folio")

   %FGP_STABLE - Wait for the folio to be stable (finished writeback)

    #define FGP_WRITEBEGIN (FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
----

Thanks, Anand


> E.g. when a page contains several blocks, and some blocks are dirty and 
> being written back, but also some sectors needs to be read.
> If implemented properly, the not uptodate blocks can be properly read 
> meanwhile without waiting for the writeback to finish.
> 
> But from the safety point of view, I strongly prefer to wait for the 
> folio writeback in such case.
> 
> Especially considering all the existing get folio + read + wait for 
> writeback is from the time where we only consider sectorsize == page size.
> 
> We have enabled sectorsize < page size since 5.15, and we should have 
> dropped the wrong assumption for years.
> 
>>
>> You found two cases, truncate and defrag. Both are different I think,
>> truncate comes from normal MM operations, while defrag is triggered by
>> an ioctl (still trying to be in sync with MM).
>>
>> I'm not sure we can copy what other filesystems do, even if it's just on
>> the basic principle of COW vs update in place + journaling.
> 
> I do not think COW is making any difference. All the COW handling is at 
> delalloc time, meanwhile the folio get/lock/read/wait sequence is more 
> common for page dirtying (regular buffered write, defrag, truncate are 
> all in a similar situation).
> 
> Page cache is here just to provide file content cache, it doesn't care 
> about if it's COW or NOT.
> 
> Furthermore, COW is no longer our exclusive feature, XFS has supported 
> it for quite some time, and there is no special handling just for the 
> page cache.
> (Meanwhile XFS and ext4 has much better blocksize < page size handling 
> than us for years)
> 
> 
> And I have already explained in that case, waiting for the writeback at 
> folio get time is much safer (although reduces concurrency).
> 
> Just for the data safety, I believe you need to provide a much stronger 
> argument than COW vs overwrite (which is completely unrelated).
> 
>> We copy the
>> and do the next update and don't have to care about previous state, so
>> even a split between read and writeback does no harm.
> 
> Although I love the csum/datacow, I do not see any strong reason not to 
> follow the more common (and IMHO safer) way to wait for the writeback.
> 
> I have explained the possible race, and I do not think I need to repeat 
> that example again.
> 
> If you didn't fully understand why my example, please let me know where 
> it's unclear that I can explain it better.
> 
> Thanks,
> Qu


