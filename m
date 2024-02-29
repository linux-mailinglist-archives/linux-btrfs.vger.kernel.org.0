Return-Path: <linux-btrfs+bounces-2883-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AE286BE77
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 02:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0321F24099
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 01:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297CC34545;
	Thu, 29 Feb 2024 01:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H3pPlJ+n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LD4RJxrg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCBB36124;
	Thu, 29 Feb 2024 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171397; cv=fail; b=RdMIUcb5Y6YVexb3BAE1O8i15qwx0MBSuzObkxHS4hQv59J3N7M+uHccvoQLa4Rd+ADxoZf25uflyqwHMp5V+uiQQBD5a5uXVuNx0RvCUzbpFJYJIpvGkM6GpzlTDHaoQnVmYe3io/kFha5JwCoUorBVNvecRuHO5fFByHyryWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171397; c=relaxed/simple;
	bh=+zAEoeTMvmQRA7AgUFeFIWV9zRQgqG63Nl2NuPmh8ZI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EPzloV9WQXvXs/SSTrcXfszIeXLlZBmabF3RqU4UbUJETtFSuiD8mT1Feod9MD9MeC71xzYofZcr+ZLMsYHiRKTqJ2lecnK1BzayfaaqMvH8iFNkG9f1DbgIExklvxOK/x3kPvoLcDD0/JAk7DllYZq9Z+ebFOaFyVdwC5QmNqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H3pPlJ+n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LD4RJxrg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SKF50E013126;
	Thu, 29 Feb 2024 01:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=88Ck2pV8bMcezzX0sefbndSGSL/Z7lYt5yUS8oT+DdA=;
 b=H3pPlJ+nyXKoi355svYepTkOZuBJUdi5xTdaD+YfGA6ttSYRPzYDsvta49337chwBkoP
 bvvCiLxAF8BNbN4CX75QKmSn4MD0gMLngjbkpi6C9HvsLOVrDT5k6hMWcYrNRrdcdCb3
 INhht4F+7SRFXoOO6ua8RgvViLSgspBCKCzZAi+Q4zPfpP8pQDFymMoBHcrIaWUgrKC2
 5/8NjhUsWUayaU4DpaTLV+QFTMT/wj4sqcBMwNz+LJexyxlR7t4cQut8Wsnsqxx6W01C
 hV7SWyVfOGVEVCVmoz362PfHV3MCAV7V4y/WouQxilEZhPglR1kOPVvNR/T3QLd/pr4f cw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90vbx42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:49:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41T0bh2s019051;
	Thu, 29 Feb 2024 01:49:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wgbdnmdmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:49:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mbway4iUlW+75GXktf87IE8vDIQPVVcVigT7Yxm+o7jnDxt9ooaAD9asLXYIKYmuk06XFbIMZ8TODkL6pWB5bdyfl3BJRfgjiMDcJS9x3FaogvUon27NtaVPcP2SnkPiqhTqixiA8k3XE/x9lw4MoHBBFXq8YZiMRxXzI+1mSCuxzy0CcJndfJ9o7p6+giyKXVUDKR6QwGYEfSDb/Segdvysp+FOg5MBe9myZ7nbhGDMTBzWIwIrIq8TCz187uIRcdWSrilxkS2FIMaKvaLteGfZSRfkm4Cb4Fxoo9ADGr0QRkNIv31Q7/fB0nuyOyZYv+3AJogQu3o3E5YYfp0SSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88Ck2pV8bMcezzX0sefbndSGSL/Z7lYt5yUS8oT+DdA=;
 b=EPp+53QWUDY8hWhByDEDzNl8rq5hh6o9GyZenBQEJ4DsQKQW42MnOy6ncOOL8ZgdEQ/n6jEjVppMBMw/dzdOVRP9JgdDurnbrkuS1f22A51Jws+TrYPPFQmFVlfCbmV4vdiWHkZKxUsvT0UTSaimC9n7DYVUDjsHmqhLu5xbxfFCtke5DgmZ170aBh3qevvHqxWRNjOVCFDrxJPLkRCB7dHoJuKkFnszLmDMuYxdlenldR4xqsvfsfkD8BNeyHDl8P7B2/RK0qnwomLr3ZnYhbnkIop0aAqVQpTdyN5T8uAiA21hvjgxBEbm7vID1a1ilOMfdYmWaa4PLfZ0dczqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88Ck2pV8bMcezzX0sefbndSGSL/Z7lYt5yUS8oT+DdA=;
 b=LD4RJxrg/xqq4OMCAUOhobf1/u6Y4hbZk/+TQ5dKZuCS1p3g+7Q3HMJItNyy77qmZgsjtFt8itHma2Upc5SU1q4+xGYCr+bvOpT9NEEcOC0sl1Tlz3cY7Y/EHmNfJJ2mC5Fg0ahvt+s7uwFFXy/6Kbe89fHVAZHYQVPrc7zMyl0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5618.namprd10.prod.outlook.com (2603:10b6:303:149::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 01:49:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 01:49:48 +0000
Message-ID: <063a6212-15fc-4c54-89fb-0223ee04e702@oracle.com>
Date: Thu, 29 Feb 2024 07:19:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] btrfs: validate send-receive operation with
 tempfsid.
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1708772619.git.anand.jain@oracle.com>
 <afc075746adfa6c6c9b6cdc73387606bc33b6933.1708772619.git.anand.jain@oracle.com>
 <CAL3q7H48P5NFqvihh2MJWrSEz_Kuup7VXMBSTmeGer4Gy788sg@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H48P5NFqvihh2MJWrSEz_Kuup7VXMBSTmeGer4Gy788sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0157.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::27) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 7adead2e-d5cb-47c8-9891-08dc38c8b623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Md8gpN6Ae3k3q7uuJNfYWiW1t+3uFnEu+kDVdifrDpA0P1Ffj7wJ5S9f3qH7Pg/RP04ZF0OTM11zyPOdHPnie/0ZqIRWWNxfyeBt22u+paQBF3p+shwP/WMEnPRc6AEWCxmMMOK4VfTO1EtEdNrU3PnOC2xkIVGtL2EPXhLRgpArGqhZjQIOFBKH+63eP56MjfZbpelY3A0ZqUkKAzZQTVPR8PiHbh0Fwu58NUN60RGwDF/uLwh0dRS3CqN/W/xZSlklAiNhtj3Z1polYs6tu3C82uRMd1Yi3Lp0b9gb2Nl+XNEQysWnCAEJmUp3fphmXzF21s1bEY111b87Fc/qRTeBdGuIuukrA+WfYFJE8h3NZysopXfUrTA6r2Dlm5lTy7NRjz0SJy6Zz8ISZNQBEQaESBtA0+wVLaA0KpwNyyF0k7ugHfLvfktybmmQxPTUYVahABR9SXFr6/AJlg8kdccirA1t1c3lvnnUUYb0L5GWlJRVN0/6LBLRK+cDXmVus8slRLJwB1BvqDeihv5TlEvWEA0EjDwK+cBTvjVc4h3xU0qAMcG4r06Q8u8hjAFKaZz5Vertdv13bmVEYx19cCO1vr63nJJVut0WkW4tQz7yNem+QLkep/0WcE+Fyn4u
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c3RxMU0yMDhYdXNtemFFbThhci90cGhacnJaZjFqY1FwKzZFY09zSms5ZkZ1?=
 =?utf-8?B?MktKdXNueFhqNHRKVm8rSTV0dVk1clZaVEs5eXlEUjRLQ0ZmWEs0TE5zN3pX?=
 =?utf-8?B?dFVzRUtNRGo1Rm1ZMy9na04rUWIxYXNmdi9JQ2xVOVlVTncrOGxnVTJRZkdK?=
 =?utf-8?B?Y3dMeXBZQmo5S1dvdlBqVEZRcUJqY044UWwyUzBhR3dxSHludUx1cTFkMGNB?=
 =?utf-8?B?ZFpIVjlEaExOWW5yd0ZPVXppcHhVMEx5aVV2NzdCSEdha1NJbU1ENFBteGw2?=
 =?utf-8?B?cks3RSt5YXNyMFN4TmgxTHpGNXlxYnA2UC9ibGV5bDJmckQ0Yzh4NnVBNUZN?=
 =?utf-8?B?WHhsZytVa2RQNndIK0NZY0ZaTjE2d2hzUHJXQXIvTXFDV1UyVFNuQjFUd3M3?=
 =?utf-8?B?MHdIYW1GeGNiNEJybUplRmxraE9OUTJiQm9HUVBTMWNPd3Z0RDdpeUJSSlky?=
 =?utf-8?B?UG1EQmJjcXZYUldVYzB0bEVIdURTSmtQbFhHMWlTSzB6a0lOM0VBeFgySWMv?=
 =?utf-8?B?UmpwbnJsQms2OEFCRW85OFpBUlNwZzA2OFA4dTFBY0dGQTI5U3BlUitxeStU?=
 =?utf-8?B?Nk5RNjlkY3Jha1pMRmYrNVQ4d3N0YWxHdGRPV1p3VGZyOGFobHpBcTZheTFX?=
 =?utf-8?B?ZzBtLzUyQy8zbEdTOVlUTzgwZEpMUUx6VVpmM0cveVpteTUxUHBwdlhscEVm?=
 =?utf-8?B?U2NiY3FndTVTTmprM0dobHlLYXM0cTA1Y0pIYlZRakR4UWRuckhkcHE2TXB4?=
 =?utf-8?B?Z0RDeDZlSnJzZkcwUDJESkpDUk8vOVAyNFk2Ung5MjFpVDdNZWhXQUsrMVh4?=
 =?utf-8?B?SWJHcHhzZElzY0J5QytETSt3c1d0ZTRFTitaUG5VenlUcm83TXhsQUpLVG5G?=
 =?utf-8?B?U3NUYWVqUm1oVEhXUkpDb1JpNmVDYm9XZ1Y3SHdKTVNqeUxOZDlkS3g3Nzho?=
 =?utf-8?B?ZlY2cnUzMlBiSUROR1ViMmZ2dCtDajBiWVlleUYwcHcxaTcySWJKMFhRNHRC?=
 =?utf-8?B?UWpqWGNxQm5iOEd4bG1BaVUwNVVFYnJQelFyUEVrelRkNmo2eW11ME93UHUr?=
 =?utf-8?B?alpzUitGQ1RFSGpqYlMwQXZCYlFxYjErVVlYdGlTa1R3bjhYWFV0YnVyTUVh?=
 =?utf-8?B?aGlWaTJUTVpmSDJwMGtiSkJ1dWxXTVIvK1JTU1ZsejFLQW5KWEVEb2FZdkdl?=
 =?utf-8?B?SGE2QjkyYlBBTWc4cVQ4OHZZSUtEMlRieVd6b0JXekJibThiMTQ5RFZyWnZz?=
 =?utf-8?B?Z1RpdE92Zy9RUXpZMy9rL3hCYUc0K0Nvc3h1bjZ3VFdndXhJcU9sakNDbUpl?=
 =?utf-8?B?NFNZTWRsM0xBMVZWOFNOUGhlZDNvTTVScU9nSnQzNU55RTVGY3NBVDFpeWRx?=
 =?utf-8?B?YWY5TnF6WDhXVzZYbGxtc3l5MEZiaUNjNTBsZVRhL01DeStFNmQvUlkvOTVL?=
 =?utf-8?B?QnZKOXBnMXlLYVpJZjloVFhQL0xwcndDbXZRdXFBbjBVeHhlL2RxZGV1UEF1?=
 =?utf-8?B?bm0zWVUyTklOZ0NpSnZ3QkV1enhuaVpLT0dyTldNdGIyZzcvTGE0RG5iSjFP?=
 =?utf-8?B?b0h3RGNPOVZGbTdvSktNc2MrK2syVjdtbENCaFZhMWpMZmlSeXoyT2pZWjN6?=
 =?utf-8?B?MFYxV1RlWWZMRW1XeWVqUE5VdS9MUk82djZncFppMjJlTUVBSnJBcjIzczNP?=
 =?utf-8?B?TkpKaXVpRHNycUtRYUhVbDhMdUFCRjluMFZjeVBISXkxUkxEU3pzR1A3WUdo?=
 =?utf-8?B?NmNZR05yNVE3LzkxUTJFNTF4Mnh5eWtKajN3cGNXc2JrLzJBNndpVmsxU013?=
 =?utf-8?B?Qm1qZ29iOVZRd01xcnNnaVBiSjQwcFhsL0d2MVJ6TzBzU2Y0TFV3YlEzZUsr?=
 =?utf-8?B?Rmk3RTczZkZHN0cwclV6b3NQd08rUlBqOGJjelRZOVkwS0pabk9wM2I1QmVJ?=
 =?utf-8?B?N0d0M05MSUhHeXNkcERIODh0OXJtYm1KTDFLeTNvSDZoQ1o5N0doY244QzhV?=
 =?utf-8?B?ME9uaXhvckxRY2NSUDRwdnVRZGVUQk1UVkMyQVYwY0JLM0xML1g0S2I5d1h6?=
 =?utf-8?B?OFFKem9WWDU1YmdBcDA3aXBNQzR6bDJ6Q1JGdzB4UHk2cjRaQ29rL3NSdmhy?=
 =?utf-8?Q?3E6bmzurrlCIEKnrnAwUDGAhM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DwKN7C4JyDUk2IVOtLIjBGA5/znfs17QC77n3By3WeCWnHwPVEa4H4g9lWaF5MvyiOf4TWCHG8R7549lhYMp5oyjvmwjAtwqwbzwInDSbBEGMhqKN/eKMkOzvZ9ZrRJ35w2rrjUhQrsZf/e6N5V3m2HkS8Kg9AP82wMPTIrw16NYGOd0qbr45vU2zRYO671/cwAMTS2/0F9fUdGGr3wTBGl8o82SwPXmgsp0y5PgQmzrGQliJIm3ec8nMGiFrtzcrz1ZEwc1rL1SQGHvEc9YNt3yBRRn6mCXszcZEOGU0QubfqgIY2nxQBZ+KJFHnB1br3HJ8NBsOD/pn5eYjG4aMH91XpOmH7p+eDOWexJrfIhKECJDRIZaKfEZ32zYySoGiRw+Am0gU3fL/YOOprSWPNde0i/AOA7L7QWlrQZEeMpTiUW5sTQyGv1Mourx84bu0hh/AEoO0LcHBQ6F+frVXn4wDg/YJK/FLSeum4g6CjkFl52k6EAHFOuRm2z5QiG7EPOEXZPxn2Gbul/NXW3Y97jPg5DKHeDPx9FAgJ3sNHkTUsVyInJe6iZQ3mmWIlISgNYqMPx8L+yOcJh8sy5fldSD0PmX+z144+nIvr40fek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adead2e-d5cb-47c8-9891-08dc38c8b623
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 01:49:48.3975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wquvUahepRc3I6arvn8Co2eihib0/zITBwFbZ8c6jNxSzL7W9DwfEzDD9+NWfkKzetFfn1BaH7wzxwRXkMlK/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290013
X-Proofpoint-GUID: 0JHQe-e10Tjbqy3J3hfpPRgpS7Aab0mm
X-Proofpoint-ORIG-GUID: 0JHQe-e10Tjbqy3J3hfpPRgpS7Aab0mm


>> +. ./common/filter.btrfs
>> +
>> +_supported_fs btrfs
>> +_require_btrfs_sysfs_fsid
> 
> This requirement of the sysfs fsid path is not needed in the test, as
> it's not used anywhere in this test (likely copy-pasted from other
> tests in this patchset).
> 

Right. But it requires '_require_btrfs_fs_feature temp_fsid'.
Added.

Thanks, Anand

