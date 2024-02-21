Return-Path: <linux-btrfs+bounces-2616-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E428885E3EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 18:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468A5283073
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 17:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE6583A06;
	Wed, 21 Feb 2024 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aVy42JnP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f+ifBusZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAA6839F3;
	Wed, 21 Feb 2024 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535044; cv=fail; b=TAnlIK1xmvTNPMFhbNyJ8j7uxcWgm9htEHsBKMh154ayUrAtNTgmSxRhrnDSn7AjmzGUy6oPMwzZut4K8I/eElNZ+hPEYINH/c/nDbPab7jVxLSNv7jlxJQ0XVUwTvWmGFdVoRrBRA2DZWH5IIpKVuwQoup5X+XhrfgVk35Ulic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535044; c=relaxed/simple;
	bh=Zmj9T+U4WV++vxfk4LgOAWBaQqODnS/O43Up1ufQH0M=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Su40cZ94lMDLqdSO+d9uhvMOb9R89Xes/jXx2ZCQn5wdOW5KXFhWqmf1T/li1UgtDw/Gtfb87DryJzHCKZWRCtJaLduLVrdFpNXIXAPXUJIbOt6EwotsVnQGIB0KqZmVebuCPmsnyc1H4swfi94ayzJGdWJ1uHmgDb+3TR8rHD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aVy42JnP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f+ifBusZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LDjL5U018080;
	Wed, 21 Feb 2024 17:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=av/LrrL8/kKr1mAQhwEJYMqZPXHlrUkD0qQ+bnzLImk=;
 b=aVy42JnP5rPsCR6aJz1Q+1ueeCacF5pWg1wZjET9iALyTaBIXWtx6E4+eYiqlMB59HC6
 4/zaHxVekJtWMBsM1L4wUHllrY3gltKCX3qwrYhVzAGeU8/5eFO4mKrpNJCBBHbJM7gp
 kJbFRy9NQqnlhz2pKNynzxniuVQoF+hm6cCpjjvMiClbbFrkiWIoXKHZc0fH0/tkOAuP
 NPxAgyqO7BYHfGNqKsACJT6ZtDtucACfx55YsH+SnzqrmctfGRVhD3W7ynWfzy72IvJC
 iyS9W8AHBuKHYnEynjHSFdWCzUIAwcedaqljvithmyPldHIjXfHypvptIJlVyEnFYu4i hA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wanbvj6ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 17:03:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41LFpOmq013025;
	Wed, 21 Feb 2024 17:03:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak899a26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 17:03:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YU4jWZa6MNfIhkLQXIcFaaAXh7IXvj7U1vEiPCQq1zdjfuUy/VlNXbuF0aKvkCNpn1xK2wA99KGJeCu783sG5gayCVCcZdZMhnBjU+ss/B5RF8UP4YpaRj2PdSWItvIRGKACDDsuh8KT3vGDgu4kG/Q9fPV9BF+BBTtGOedEHeLbjSDi7WrgPBflIGmyeq/tM4HdDR6K5pmU1K8xaD6uZl4YnB0Zgo8jTRKG7WpOH0LsOMyb2YoHA9nFlOl+LPTSmRWLdMX8lrBdhz00D7o9YG1zEdA2F+QEMgDDkgwhnaWDVb3oeEq1VpSRcAn4B/9MNP+rKUjyEIKS81dYIAII6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=av/LrrL8/kKr1mAQhwEJYMqZPXHlrUkD0qQ+bnzLImk=;
 b=PI1oZwYUpgTuTXlWWYQ7AM3oCH7sHxK0tHUjIwQXk5GN8kRVcemc6lRSQtyF27Dt01j0m5cofpzONtUlj8pCaJx732wRHUJ24S3INDierX8KeS/J6rqKCr10WZkkZoD3u5TFTdIQoNNzW3WLHFvS2+P1XE/BLLCWkjA3HnZSPMS9Rc59DLmZpk0dfgxjHb0ifXa/5oV+5dneSVXrbyeqQMmsH3d9BZ27nvKVvrqhFbPvm+ZVVlEnVT5ZG9dm/OiJWCX8M1EMXji9WqqXD54oIrDbEsQiPdAdEaq9kCpw7vgL+P8kIUjRJ6qpWn8aXxzFCtdq1I58UGYAwK3rjn1LZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av/LrrL8/kKr1mAQhwEJYMqZPXHlrUkD0qQ+bnzLImk=;
 b=f+ifBusZjGUMDB1dlXSTMtgs3QFBguBrr/4WaIGagPW/S6hW6ixhA+1BYDj5kdXa/S3QW3uob1v8zO9B1FsDWV9RMAwYf5jTy2X+FBMtQBKu/lbCtt9m83gbMeJKQwZWo+b7MOIDo/7WFrqvUpTjRdNXbwSgnWKx1dHHAm2lIZ0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN4PR10MB5606.namprd10.prod.outlook.com (2603:10b6:806:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 17:03:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 17:03:40 +0000
Message-ID: <5bb804f4-025f-458b-a36f-756871bb3fff@oracle.com>
Date: Wed, 21 Feb 2024 22:33:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: do not skip re-registration for the mounted
 device
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, aromosan@gmail.com,
        bernd.feige@gmx.net, CHECK_1234543212345@protonmail.com,
        stable@vger.kernel.org
References: <88673c60b1d866c289ef019945647adfc8ab51d0.1707781507.git.anand.jain@oracle.com>
 <20240214071620.GL355@twin.jikos.cz>
 <CAL3q7H5wx5rKmSzGWP7mRqaSfAY88g=35N4OBrbJB61rK0mt2w@mail.gmail.com>
 <20240220181236.GF355@suse.cz>
 <bdaa5790-56d8-4490-9eab-9a47e4926661@oracle.com>
In-Reply-To: <bdaa5790-56d8-4490-9eab-9a47e4926661@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN4PR10MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db0eafd-0939-4524-f7fd-08dc32ff0d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UncPDnhVXgLprMR4N1VuwxYjQ4c3rr3M4eW0ANhVBLBgr+AthWr0kOhoh5LeviSnWgj3DUSYn8aNfz2afbsVgBDDrITMObNDcE5BgbNmY8swofBDkeCqmr/IixyM7Fwnw+rfoPx1n7rPqlN9j+Gu+NyZJW4/kGd459o4vSMnfRybPy8nIYaoKA9RIYzJAbYQNntIpyG/tKKVpHtobzgJEJFV0gJ5bMfh8b6cSWRheK/IYgEptj9p6LYtu9b6wa2wS+gQXcwJaUQtiB+pVTcSRcedATyIM7JRko5KZEky4CdQ9BnM/cSE6z6DdR3Gqnfs5ze+UzfQ1tyMCh4A5laOsHZgDKYR3ezL1lDZfvg97ESRQz7yJavy91e6IRpMYhrGw7tMaoWEcVcqWAvdxT8z2kyURmFW9MZhooDOhvlMq1sVGeCeekmccP5+c5O6y4VeMzA8AYPp8fX5H0ti0qsbqB9AsMtL3Fo5IKIicHyF/oHFysUm5NrnAGSKc51AOuE2qZ90Y3aenNU8Qo5HmFDJWA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?azVUS1B5SkZ4TGdDajI0TS9ZSkduRmhSbklPK3RSKzR2dzJ1RXcwdysxU0dj?=
 =?utf-8?B?eHB4b1AxRHl2UDFuanZmV1RUZDczNHhXenRsc2lHWkNrdmhxVkNhOXl1dTNS?=
 =?utf-8?B?TXFycXdoOE5keTB1T0JSNW1XM1BSemNQbk9DZCtweE4xdEJiaVBMY2ZQMzFm?=
 =?utf-8?B?R2M0cnUxaUxEdGR0emlOTnJVbk5qckw5eDhhUGN5WFYwYitpZGwzVzArUzdP?=
 =?utf-8?B?eWVqblEvdEFsbDFISUJPVU1nVGZQR1BwUWRqT3ZpRUJRUXIzUjVlbWo2Rk1r?=
 =?utf-8?B?YTVQZDFIN1l5OTlJdjNGaDlhazhLQW13Wi9kQWRCRFJaaHNudkdnU0RMd2Zj?=
 =?utf-8?B?N01nUXhpVzA2UjlmT0IvbnNVbW5sRUZ1VitzMi95Z0pyUDV5cVQrcC9oWTFG?=
 =?utf-8?B?SHdjMXA5Q1hwWmp4cGlsVE5PeFlBZXFENjg3Y0g2cW0xbTk2cGNwZHVXRkN5?=
 =?utf-8?B?Tk9jQmtVMW9rMlJ2UGxYZUl3Zi8vbDJVbGcrc0NtU2tVZlEwVFovUU44QU5Z?=
 =?utf-8?B?Q0M1SXRRNmxDdzVNQWZTZVo4VlhnRGNLUVZGeGw1RVJYZEpFNm5weXlJcTRp?=
 =?utf-8?B?UDNFRGRyU29od0I4bFlsVEZiN1hQckxqTXJnZ054UWwvNk14SG9neDJVQTFp?=
 =?utf-8?B?blpaYWxhNi96cHJ5OCs3Uk9nbG0xWnRBNlo0K0djaXBIc0Q1Yk1aakU0dlAx?=
 =?utf-8?B?RWlzMUpldFBIakdaeHVQU0xzWFFNaTBuL2QrU2k5VFZGa0o2Yk1YZllQemdo?=
 =?utf-8?B?UTloRlBPdElUVWhaamxpSENqZWlZRmViVDNOYjl6Nm9tUGVMbERXYXJVZWNs?=
 =?utf-8?B?ekFZRUc2dDYvQnNaMTJDRjB4dFA2enB4UVNRWFZDTVVqRFNGTkVnS3dvZzBO?=
 =?utf-8?B?SjBBUXlaQWRnbC9MeUZOSWxJUWtvNkZQVFJzSDB0T2pPZ3dLVFA5akZZR1U4?=
 =?utf-8?B?L3NLT0RUQUIzYXZEOC9QMGxBYVV1NU1rL0hWMHFONHR1MWtCRHJYd3N5aGxI?=
 =?utf-8?B?a1pvN1hHNi9UVEFKejgwUWhjNE55aFBhTmZoenhDZEFzQWVXc2psUWVNMVVG?=
 =?utf-8?B?TVc3ejJCT2JzTDhxQTg3NEpBdkdodXBDNUpiOWY1MVFPcHFITUx5YWNFRUNF?=
 =?utf-8?B?SWdhNlBheUxmV3A2M1oxUHY3UW10anlzZnhRRSswZE9icGloSU1UMTBLZUxT?=
 =?utf-8?B?RjVtRjhKS1RySTA1cnJwVmNYUnRWZkE2SDgzZ2FYZHlrajNydmtJNWJScjI5?=
 =?utf-8?B?K2JqekhPZ2UyT3V4ejZ3RGpXaWxJaUNNRzVuZnNHMnJJdzhXa0RQZ1pVdHZH?=
 =?utf-8?B?U0ovTUpWdVo5a1lNb2VLVjVPeUFPWkJFeGZ3cUovQ2Q0S1ZGOTI1bnRobWZh?=
 =?utf-8?B?MEVqOGZBWUNCWm1TOHpERGh2QTA3dm5NcDk2VEJUODlJdWE5S0pkUmJwcXZh?=
 =?utf-8?B?SVNZTDNKNS9DOU84dFFDdXdJTzJDTEFaUmFpSGhDUmduOUs0M00wMzdrNmRQ?=
 =?utf-8?B?RE8xcVZ4L1R1WmxyazVZZTlqMGVhSmhUczNieUZZcDl1dUlDemJuS0hSSm5o?=
 =?utf-8?B?eUx0VWtIV3kvVXY0OERGejBQMDhzSTlCSm1ZNUZZZXhYekRPSThseFZNVzR0?=
 =?utf-8?B?MERGa0hwdWZiN29VNnRCWkJHMVBHdkViazJiYzA2bFMwTUFwRWFzQjBrUlVO?=
 =?utf-8?B?NHdSaWZJdkphRTZsUWNCKzUyd1NpUXFaMitEQUZ2bGorMlkxdFljZGNlNWEv?=
 =?utf-8?B?U3JWa3h3eGNDTDZuUCtMWjFzdnNTaERrYmFBek04THhXV2RzTjRTTGRRNGFp?=
 =?utf-8?B?QU9qUndWTUxRUEZZZEVBS2lSVXNCMzM0YzI0T3NrYzRiSTlvcEdpQjMzTkJI?=
 =?utf-8?B?bzh6VUpjaFZFbitQQ1V0VkZKakZMcm9iWGFzS3p6TXF2TWx2VkYyUGRzY0ty?=
 =?utf-8?B?OUh0a2k5bzdZcHQxUTllTDUrK2xIZ1dPRDNMV0pZeFVrMytTWGZyVlRDMVFX?=
 =?utf-8?B?RUlHZGRPRG8yZzMwNE15cjF1cnRRYTNOWHQ2SiszNGFac3R2SzBTemZGdDlj?=
 =?utf-8?B?RTdJN1RjNGNSZzQxZ0FleEFNY012VUFDY01qU000WnVxeHY2TE80U091S3k3?=
 =?utf-8?B?TWlFM05LUkpqdWRmSlQzTzlGbUhlZ05RajBHSkN2WGJDS1ZOdlYxczgyRmZp?=
 =?utf-8?Q?OO58uLcgbDMTUrY/fQnTPogNCwwsMx7jTkivi8+ZueQ2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Cj7s7jqqVy5pFzuudfIOo0+le2H/OggxASU6Aw6MhE186lFmeUwpwDBHD9162tlrkQuNmc7EYnB8Soelt/9d0q88jqd9QkqNTGeAp46BGnUXnzakhctleNIlxcCewK2qrP/rZnVxivk8lAdW3C/YXCf5OAXjmyVw/DDQ3CZkyee8wAyfCnA7Mrqy1vJ0YRAf+V2AAUsgTcwHkdHJ5lIUlJ0IM9Ge3BZaWMBZhDHd0yU0xHc5ssFsuO8dmJf8IeZgzZPBfV+A09XtxzdSnifs29fWOViIqRuaeyL/uNj5trbCCVcVfVaTSutMvvMFmZZIAVnJtP+eJacWjC6G2DuKKg1ePKP0C5+1em0NmWs2+0fJksi1210rLUOZ0yISYOGgxXolzNVfWGi74a0Mzm0wOGaiYa5YM6tMQoXqmtMjXsdofxAHHfhTq3q2awDto/07PckU28KXCNwvKcbFYAyh67ryd69U64ibBs7f0RFOhhLZnZWCj/TU7iM2SoaHKcval9iY3J3089lL0kC1X3lQTIG7YVdu+GS9r37uPVpAbUf47Ua3sVosRnV2t7IaVKUSb+kVBfhpPkN+OUEHiwNaQxcHPvNrSVL1bWJLCECOejc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db0eafd-0939-4524-f7fd-08dc32ff0d38
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 17:03:40.2820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQAPKzTY4yjw2nBKY2IcoRe5Fs4eGMzVoELfX4tTEu/3RvguBlqGw11KcROMlFGwBb2gZ3HuuwNenWonXVrYXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5606
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_04,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210132
X-Proofpoint-GUID: oGhnwI-exSkxTAhYHhuNEF2kr6ZQN-Ph
X-Proofpoint-ORIG-GUID: oGhnwI-exSkxTAhYHhuNEF2kr6ZQN-Ph



On 2/21/24 22:09, Anand Jain wrote:
> On 2/20/24 23:42, David Sterba wrote:
>> On Tue, Feb 20, 2024 at 02:08:00PM +0000, Filipe Manana wrote:
>>> On Wed, Feb 14, 2024 at 7:17 AM David Sterba <dsterba@suse.cz> wrote:
>>>> On Tue, Feb 13, 2024 at 09:13:56AM +0800, Anand Jain wrote:
>>>> https://btrfs.readthedocs.io/en/latest/dev/Developer-s-FAQ.html#ordering
>>>
>>> So this introduces a regression.
>>>
>>> $ ./check btrfs/14[6-9] btrfs/15[8-9]
>>
>> Thanks, with this I can reproduce it and have some ideas what could go
>> wrong.
> 
> 
> Thanks indeed.
> 
> I see some error during mkfs.
> 
> ERROR: /dev/sdb1 is smaller than requested size, expected 1073741824, 
> found 766509056

It is reproducing the wrong problem. Please ignore.

