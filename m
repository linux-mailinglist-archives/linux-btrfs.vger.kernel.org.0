Return-Path: <linux-btrfs+bounces-3285-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C1D87BCBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 13:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14969B21C9D
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 12:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86066F53D;
	Thu, 14 Mar 2024 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eH0320I1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TYB7GREo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2010A6F50F
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710419104; cv=fail; b=jI0JbRd4bR5MljZjWh5IJ+XXhjshj35m+xHYON+GQDKbMEnMkXBjE+dewbic8Xy+O0Jm75bq5Kxms00PiuSGQJtT9LltEML9cBjPL9+7f4lgAkvE1S65/RQWNe6cN6sKt1yFn/twAcaxILJnwiPmJjGw57fET9c/dbVERVaUxvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710419104; c=relaxed/simple;
	bh=QaOMLR1Wj9zm2ha//CPBR/gisYUuTxKyRBQH4GZ61eA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k6iVX4tkm/9MqsVyhOefHSPzhu0hGM986aPad+1Fvum+DRb9AGASPV2KZBb/Ls668u328OLvWsXDm2Unsb+elPMWdyVwnD0jPdholD0PaVpuvplsI/rWAXcyQ+1gy4N6+4ZqpI9heDJShC6gombt9aMzeZ2/1SorRGturMrz9jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eH0320I1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TYB7GREo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ECLl6E002210;
	Thu, 14 Mar 2024 12:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=VXzh/EeB8n492AE40mrtD+QbYDSTLsry12JLfYk9MHA=;
 b=eH0320I1dXa70DwWM993ELaBycNvAkrZ96sd7+uJAJj6bSjnPL+rYL9oRWqrb5PiltaS
 JX3rFlQx26zIWmXPftHj/oNWpoKt41AMhUYLL9RJ5q+fJCPiRAK0aFRxV78Z64uMgSbG
 4i15k+LGGBPorZ+jnaJBVeQthZrBfKA/j+MhYmeOp3A8cMdB7mcRgs6Mxz9f9ih21Gc9
 p+/rdGU37WBNbyNr0QWJKzKG1OyChYlJiPNtIv+kvz2/FxX4a5MCHQ3cgYSSlyfBGbKq
 9OsjwgRerL23kLd/PUOM3TM3ACl/HXJxF4SPs8UtQbgNU3ka434UdM+vo1iSXBOA1y5t yQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0abr3au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 12:24:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42EBSffE033770;
	Thu, 14 Mar 2024 12:24:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7a1r9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 12:24:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbQ8krouJoz3kvigWvg07RqSXDMn+O4NUCyPSUVXuO94e2eIECateTJXMhEY8woN+DoBA4vwbWVyJgcBNa+jwuhl91xYqZ1NmUAZlpp+Xd5Sd/nS9AhBiiL1vXjXwcYZEYj6GSruA+NTXBL6iBrKEMdryZZrDpwmlZOaD8xATooAGlsl10AWrP2A//c6XISV6MSjGr4BhoLv2THm6/m47WxQw1Ul/MMkd0yfyTVtXAF4iwlxfkKE6FXkPg1WV+lTyNSC0L8l76BUvryZ7PlWS0UjP8FSSAH+khbl869zQCz5+tXK0Xer8C0yryAtXf2Pi0Ats8iz28/eOM2i+Dt4nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXzh/EeB8n492AE40mrtD+QbYDSTLsry12JLfYk9MHA=;
 b=CrtNGBdY6nCRKB1IlSHBBW7zl8N+HWxEI6YN7dX4HyTJQ9LDlCaxULQ44VXDhxs1Ro/o8q/ntyxVYLxnoJRgmwYh507OJPiJvPMMrrhtKZ5JDvTgPY02AuCs38OkOxWmjy0Z00zivIrAbA7B12AkEXSSSSV/uafEGQu8AJYOvGlgWwpMmM+z9my6WJJZLjdXDelKmRIW5QaOxgNaY7oo/uKSmPDe3Z960lMKGd3hyB1n3Ixl+XLqEb1zKq5Mndz/yjUZeqG25t1w8ObmOWpwgMCh0zS5oQp4RtiB6iV1cUNh+YBV6hToC/5AiI6LHax091mJ4k5iTf4n6IVA+PwLGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXzh/EeB8n492AE40mrtD+QbYDSTLsry12JLfYk9MHA=;
 b=TYB7GREoeofNVM2iRI//4k08dqYU/uiiQ3IuUKdp/ydc6h59Tdm6JOhiVENjPFXkGzQfwNcfqurPacmz1knaRAnpDNw01ZHa6E7Rgv4oIhVXkXcnQ9/jwDKORs5Atr2Ap1o/s9aRijiFPg/HQI66cJfKu37+hOI7hHQH9BkjmsI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Thu, 14 Mar
 2024 12:24:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 12:24:56 +0000
Message-ID: <1b78f6ea-04e5-41a9-9699-57ce70116870@oracle.com>
Date: Thu, 14 Mar 2024 17:54:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] btrfs: scrub: fix incorrectly reported
 logical/physical address
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1710409033.git.wqu@suse.com>
 <ad7fa3eaa14b93b96cd09dae3657eb825d96d696.1710409033.git.wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ad7fa3eaa14b93b96cd09dae3657eb825d96d696.1710409033.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4497:EE_
X-MS-Office365-Filtering-Correlation-Id: d1822290-3817-41d6-ff67-08dc4421c231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+9E3Ya4quFA8js/rEPRze1phS6SPrqbHWav0NGm/RofpAchKpPC4At6V5BJ70LQtcv/YXx7ogEValPfB1mrgnJr/7g97DzJZBSnodWT20O1TythbfQ8PKMHvTb+v0i6nDfcwjle0zwpEmAvrZci9C/AVf+2KHoUl6b1m0NpK6Z91r1hJeFHf7A3qr5IeTEvu8S+N8Rgjb4AGstefgspRXB82qOgQRlGHOlWO8k/ajfC09Qbh5wIynsWs3aH8KRkc0mpikg3EpWcVlOXx0CyEEyu7ttT4NhMPep/isNC9wJ0N0OV6ZgboEXc098DK70KUL93VVKeqgjbd6seaHXdowI79DsaeO42fW5dSNjCiaozIIY9bZvgmIVmvfUL6Ypc9RaTAbaY6pjolVy/ZwmEdhVfFltzUKhCXuTx5DLGMa401c5yn3+CxJ5hqtLqhnAJapYG88y9+lUl48BLt6UGXW++X01CjNx1xhlOjP3gr83eDbs6uBmY9Z7wenMKYOFhWbG+f7IcjR0anTnyVsEX6XSXtppD2qYHcvHsqog+baYLcYKDsu+yP3zgr0vdOkW6Q9dgL3dGaqfNUkA6U3RMqGn9slWXwOQel3SaNqKupZiOISOgqKD4HdNee9LP+IePi9X2DFCCm2HcgjVcd6vHt1jK3eDLgTs3XpgX7hBMUInw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bEJVUmgvcVZ2Q2hINHlLU2hwZEZ1ZUhMUGMvb1drMkFYV3p5WjN2a2NYN3I3?=
 =?utf-8?B?ZS9wNEtVdjNFc1k4QzM1Q2k0MUNqTHQ4SnptSEhDM2t3SGN4NGVrZTJuanho?=
 =?utf-8?B?cFdqU1BkU2FXc2pVNldiQWxpNXZITC9KSlBmTFgxNnI1T3NMbCtCalYyOEJW?=
 =?utf-8?B?MHZFVVJOR28zQlpOb1FCaCtTNms0bk91ZGFnME9lSGhRL3VvdkxvOEl6ZzNm?=
 =?utf-8?B?NlZ1ODBjWlArM3Jqc0E4d2xqSktIREtEakhPdDFvbXNHdzltT0p1OTRreHpS?=
 =?utf-8?B?K1hPSmdCclNRcnhsMTlKSkl6cjI0bGNrVmZmaklwVi9JUHN6WHVkdjdMVnpn?=
 =?utf-8?B?bGYzM1d4NHR0UWZFR2xPajZYMVU3UzlkYldXV0lRaEZYWnJ5RFNVVnFOMDV2?=
 =?utf-8?B?OWxCa29XK0JsbWNMRE56Smo4ejU3TGhsLzJPa3RSZHE5K2dnWDJUSERwNGQ0?=
 =?utf-8?B?bnVrTnlKSkhzZFVjOEVERXpjWmg0eDE5M05jdXIyR1R5M3h6RGVYVlk2dXJJ?=
 =?utf-8?B?b2NhMWtlT09sbmZHSG5DUXNqUHFJK3Jnc0p1UXp6a3dNYkN1aytueGFmQkFW?=
 =?utf-8?B?RHlEUDExd3grWlVXTnVjWHRBdUMwU1dSKzV0bVRMbVEwQnhJckRsL2ViRit1?=
 =?utf-8?B?NFNyNGNDSktJNkpDTUtEUGFIWks3b2pzaE9YQ0JBWlhnWnc1MEdRU29MK1hJ?=
 =?utf-8?B?Y1ZEVmJsSm1vb2NYd1RnZTQ1eFFveW9TN1dzWDhwL2YrdUVhb1pVM0YzMDN6?=
 =?utf-8?B?VnJNK2tKZ09DRk1oQ0lYUFFNNEVZMWlPbTBaeHdwdE9HUDFDMEZkRi90b2lU?=
 =?utf-8?B?cTRSMVk5QnB5YnJQQzhBNzJCWi9acXhKcXIyaGxzdmp0SjBuc0o1UHBVNW0y?=
 =?utf-8?B?TG5QK0UzcmpHUFBrZjlzZU1IYWUvSDZNT1ZDL1llM1ptUVdyZ2o4d3YzWEVT?=
 =?utf-8?B?ZW0rRUdlZXBYSWlqc1JxNFlPRHZValNJbVRka3lHZzVGRmZWeGZqNXMwVWk1?=
 =?utf-8?B?TzZzMFAzNFRGTnpkUVlDcUdwWXFONU03SnZaaFp3WVRvdEdqeE9ZYVhtZWRL?=
 =?utf-8?B?UUtsVDJsNDNoS0NST3IwQ0hCK1lZY04rSWVudlY5Qm5tQ3YwK0V0NFlZSEx0?=
 =?utf-8?B?eCt2UVBIYi8zcW5od0MrOXJPSFI4YzJ1ZU9VV1oybk85NnZxL25oQnF2bWNR?=
 =?utf-8?B?bWNjY1E5YXRWY05qK2ErUms5VjN3Y0pValp2MGQ2ZGg0ZG1lL2RaN053ZDV0?=
 =?utf-8?B?ZSt4aC9lZm1wcGFYZE1RYmEyMFB4SFllTXhiYVFmTWVQbFZHbldEVjJSMStY?=
 =?utf-8?B?TmlEblM5a1FTQmpVYWRFS3BEcUR1eXFZT3d4cFZnL2RvaU9SaGFObXE5Yktt?=
 =?utf-8?B?b004UVdFVmpBaXp5bi8zZHpCR0hJUEJBaVh1RnVjRldSVC9ESU1sZXhzVzJu?=
 =?utf-8?B?MmZLYThUOHJXQk9zS3JhNFZLOUI4U3lGMWs4ODZOdDVBdStib3Q5QTdnZmFK?=
 =?utf-8?B?WG9UZkl1Z0k1RnEzK0VHMnQvZUV3YXYxelpXOWE1Y25XNlpCNjlnbmpQa2RM?=
 =?utf-8?B?WmZPSXRuc1lBOXhXcDdjamlQdE5jbjRsWFFsU1RtZld1T09iVHNtVStvQkhH?=
 =?utf-8?B?OUR3Q3FoTm50Wmg1bTVzalB0Vk9EbnJFL2VndG1TUjN0MzI3bzgrQW00V3Vl?=
 =?utf-8?B?RnJQZ3dFVUl0VWZOK3luTk5Odm9hYlFySU1LTnJRVitvS2pBZjN2d09wb2o1?=
 =?utf-8?B?dDBsV2ZySjE2YnVSV3Y5VWtHemtyMXlNNkR5ZlJ4akV0OXB1Vmh5Qi9nZ2dE?=
 =?utf-8?B?N2EwQjJpWGZXTzUyM3JIaHdjZmhuTCtrSUprSk4vbWJpczBPQlpGUDVvT2xO?=
 =?utf-8?B?Wm1WSnNCc0tHbU1NNEt0SnlsSzYxNGYxbUxQWGJLdG9RZ3hTdC9BMGZlc3Q3?=
 =?utf-8?B?TzRpaU84aklsVVEzeUUxTkxMZmhnU1lvd09TKzBwYUsrdzRyN05WVkk5WHVx?=
 =?utf-8?B?ckJvdHBvN1ZYbDFHcyttVjdiWVpXS1dlMFp1eFREUEJFZTFhMk93SkZpemNh?=
 =?utf-8?B?L00va3VLNytYeTNnQ1FBYXR6K3J0aS90VVkvK0dyUzBYS2VvN1F5bk9Yd2M2?=
 =?utf-8?Q?w/vdI5ZGAzERiSsPrfN+uQgn/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Urv/6VmbV8aLp74W4+OuWqHIwq0Go1ahwhKubSAM/+bBh/xZ+wWMomZcNzS9ZzdWj0mSeWVPbHAS71SCLFN65Y4PbllxJ13sEmPgoN9BGdYTf3F+mKpA9Cbz/os1GXvSK/ZVgNNzACyH2kDm1ZmDe4eO0TWpHJh4D4uRio3XaCwoHtKcXaLDNkN0whVfl2LGCCQCjospzwEcEiLaI3t7I2UwentYyjX+QIcGQK3H2NlHVaf3l6QEHt157pj8zZcIN5myd2vR9X293VJeIpACAE27GWYlapCMEfdF7CaB4AAd2C5ofj+pv0NFkcmOKNKIiYSWY+fhcOnOBjRRigoQRLyETgzI8/9PA8bAtkEQBRLdB+x6BQHlczKYEzB5GuhWLFMhKqmUW+jzUiFjOsAuGPLOBoOzwJgUci6lMEs1BYpB5dCHjgmd22BOr2iXQdoVLTpzwMl+JDeIVudsqKOPDnHLTN/+NKIG+n9msXeRF8m4AroWTqdc2tlSnup10Auwj16etx2khpRbgXrPnC9Jm2PBD8V2v8ImvL+SbDIuSC35aY4T4uzbfItJlCvO0HVKF01tlRF5JeShNGox+aA8ELdXBXyhHTpg1fzdAPO8YNg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1822290-3817-41d6-ff67-08dc4421c231
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 12:24:56.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjMSf101YL9aPwJTakDPp8NkZiA3w+0uZiDeWPPgz9AQSGXd4d3ZnX00BBi65qLPNDtATTN7I5XUYAl3ung+bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_10,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140089
X-Proofpoint-ORIG-GUID: 2ojrfWw6wHKXNhGwcccuginZ4H0EInZy
X-Proofpoint-GUID: 2ojrfWw6wHKXNhGwcccuginZ4H0EInZy

On 3/14/24 15:20, Qu Wenruo wrote:
> [BUG]
> Scrub is not reporting the correct logical/physical address, it can be
> verified by the following script:
> 
>   # mkfs.btrfs -f $dev1
>   # mount $dev1 $mnt
>   # xfs_io -f -c "pwrite -S 0xaa 0 128k" $mnt/file1
>   # umount $mnt
>   # xfs_io -f -c "pwrite -S 0xff 13647872 4k" $dev1
>   # mount $dev1 $mnt
>   # btrfs scrub start -fB $mnt
>   # umount $mnt
> 
> Note above 13647872 is the physical address for logical 13631488 + 4K.
> 
> Scrub would report the following error:
> 
>   BTRFS error (device dm-2): unable to fixup (regular) error at logical 13631488 on dev /dev/mapper/test-scratch1 physical 13631488
>   BTRFS warning (device dm-2): checksum error at logical 13631488 on dev /dev/mapper/test-scratch1, physical 13631488, root 5, inode 257, offset 0, length 4096, links 1 (path: file1)
> 
> On the other hand, "btrfs check --check-data-csum" is reporting the
> correct logical/physical address:
> 
>   Checking filesystem on /dev/test/scratch1
>   UUID: db2eb621-b09d-4f24-8199-da17dc7b3201
>   [5/7] checking csums against data
>   mirror 1 bytenr 13647872 csum 0x13fec125 expected csum 0x656bd64e
>   ERROR: errors found in csum tree
> 
> [CAUSE]
> In the function scrub_stripe_report_errors(), we always use the
> stripe->logical and its physical address to print the error message, not
> taking the sector number into consideration at all.
> 
> [FIX]
> Fix the error reporting function by calculating logical/physical with
> the sector number.
> 
> Now the scrub report is correct:
> 
>   BTRFS error (device dm-2): unable to fixup (regular) error at logical 13647872 on dev /dev/mapper/test-scratch1 physical 13647872
>   BTRFS warning (device dm-2): checksum error at logical 13647872 on dev /dev/mapper/test-scratch1, physical 13647872, root 5, inode 257, offset 16384, length 4096, links 1 (path: file1)
> 
> Fixes: 0096580713ff ("btrfs: scrub: introduce error reporting functionality for scrub_stripe")
> Signed-off-by: Qu Wenruo <wqu@suse.com>


To help accurate debug on stable kernel, we could also add
CC: stable@vger.kernel.org #6.4+

Not too particular though.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.


> ---
>   fs/btrfs/scrub.c | 22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index fa25004ab04e..119e98797b21 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -870,7 +870,7 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
>   				      DEFAULT_RATELIMIT_BURST);
>   	struct btrfs_fs_info *fs_info = sctx->fs_info;
>   	struct btrfs_device *dev = NULL;
> -	u64 physical = 0;
> +	u64 stripe_physical = stripe->physical;
>   	int nr_data_sectors = 0;
>   	int nr_meta_sectors = 0;
>   	int nr_nodatacsum_sectors = 0;
> @@ -903,13 +903,17 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
>   		 */
>   		if (ret < 0)
>   			goto skip;
> -		physical = bioc->stripes[stripe_index].physical;
> +		stripe_physical = bioc->stripes[stripe_index].physical;
>   		dev = bioc->stripes[stripe_index].dev;
>   		btrfs_put_bioc(bioc);
>   	}
>   
>   skip:
>   	for_each_set_bit(sector_nr, &stripe->extent_sector_bitmap, stripe->nr_sectors) {
> +		u64 logical = stripe->logical +
> +			      (sector_nr << fs_info->sectorsize_bits);
> +		u64 physical = stripe_physical +
> +			      (sector_nr << fs_info->sectorsize_bits);
>   		bool repaired = false;
>   
>   		if (stripe->sectors[sector_nr].is_metadata) {
> @@ -938,12 +942,12 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
>   			if (dev) {
>   				btrfs_err_rl_in_rcu(fs_info,
>   			"fixed up error at logical %llu on dev %s physical %llu",
> -					    stripe->logical, btrfs_dev_name(dev),
> +					    logical, btrfs_dev_name(dev),
>   					    physical);
>   			} else {
>   				btrfs_err_rl_in_rcu(fs_info,
>   			"fixed up error at logical %llu on mirror %u",
> -					    stripe->logical, stripe->mirror_num);
> +					    logical, stripe->mirror_num);
>   			}
>   			continue;
>   		}
> @@ -952,26 +956,26 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
>   		if (dev) {
>   			btrfs_err_rl_in_rcu(fs_info,
>   	"unable to fixup (regular) error at logical %llu on dev %s physical %llu",
> -					    stripe->logical, btrfs_dev_name(dev),
> +					    logical, btrfs_dev_name(dev),
>   					    physical);
>   		} else {
>   			btrfs_err_rl_in_rcu(fs_info,
>   	"unable to fixup (regular) error at logical %llu on mirror %u",
> -					    stripe->logical, stripe->mirror_num);
> +					    logical, stripe->mirror_num);
>   		}
>   
>   		if (test_bit(sector_nr, &stripe->io_error_bitmap))
>   			if (__ratelimit(&rs) && dev)
>   				scrub_print_common_warning("i/o error", dev, false,
> -						     stripe->logical, physical);
> +						     logical, physical);
>   		if (test_bit(sector_nr, &stripe->csum_error_bitmap))
>   			if (__ratelimit(&rs) && dev)
>   				scrub_print_common_warning("checksum error", dev, false,
> -						     stripe->logical, physical);
> +						     logical, physical);
>   		if (test_bit(sector_nr, &stripe->meta_error_bitmap))
>   			if (__ratelimit(&rs) && dev)
>   				scrub_print_common_warning("header error", dev, false,
> -						     stripe->logical, physical);
> +						     logical, physical);
>   	}
>   
>   	spin_lock(&sctx->stat_lock);


