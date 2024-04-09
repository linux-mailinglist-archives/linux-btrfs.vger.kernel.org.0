Return-Path: <linux-btrfs+bounces-4044-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D38089D115
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 05:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4FB1C21D0B
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 03:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586BC54FAF;
	Tue,  9 Apr 2024 03:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="la5ZafP9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w76CRZDX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD212572;
	Tue,  9 Apr 2024 03:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633601; cv=fail; b=jcWXIF/PGluAnl/qcneUL1nsNFg6RYOvY+W8msk+cHDnuOS053xR+IEka9O+SpEU0LYaK7jSUprm64/NnYezgHtkgInuCVGy01/bUejLAayU9IEAvzZHoPjZkapxqlCTn2OGA6tO+Et5u7cIbcsxKN4ZAn3+EGXV0cGPy7+f2k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633601; c=relaxed/simple;
	bh=fH39j1A4cxiOzGaOk4nqSL3lJcqj6eOxqAStuAonbk8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tor2xnETndm23y2e9/4oMbxR3fBdPzbZFUNbNI4UbQWDYdakbQkz4HSLeUgAFsPygItAbYJZbHqH9sidp1E6imzpuguYnCbbsLfVTmog3fPkmTPVrLmfXgtexgM9MZ8Xm5G3rsRgndV/UJd9Qf+lQk+/m7C3askyzI1NiwiPS9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=la5ZafP9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w76CRZDX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438Lmm38007701;
	Tue, 9 Apr 2024 03:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=AXhCqp/dJ9ql5aH/D2eZNLm6Pk/HKnm38q65+e3W2xY=;
 b=la5ZafP9sl/MuutrJa0E2YsbCzw80C/EbVkNYcdzMejW0uI7rzIKE1gdeGvw4gmxSSCE
 wtGWTWdGCAIFYND1BINGwpgz5s79xKaFLxpXfAe8xkdm2NhAtqcciD4R77+mAWGhx6cg
 GnKP2mSnxcwxxDFUkfjLQ8Nce3TVXee5RZRh6grr+6EO4ZZvOG6M3okogV8TY8XqKzQD
 nX4HkjeSFaU1EpHgpW2de1R+XLzJ2A4lr4iOHvBuVRlAwTTlGR4hayCnF2+ryvj80nVx
 9rj9gCZ4mkXcN7P4AMn4uuCTp6lySIe29zA5nn6g3z7B+VcS9hBV9b8Gbr5wHcW30g+h 3A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax0um5ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 03:33:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4393FlwB007862;
	Tue, 9 Apr 2024 03:33:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu69xas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 03:33:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkjcJUwLdLm1aucGXJSvYL/I4s3rBYPITm0QruaeOGaVJxkNCQi3tOBCxJBbgGdvL8VJSEtqOenzBD4aEBR4NExvKGTVNOe2DaNq++1DLbgoHrmtKxbbjs5z3GI50g/qStyYPOURuG9Z3M+4JXDw+i2Jai45cnZqyZUynlPeUsQpAb4zqe1VZhIEMY3pHRg44h9gFScc0vDK/SMu//tV4cXQYL/3uU8+6KmguelAUwJofLueiYQ9YDp7jkfsmO3GwNvZ0D42dTuqmi85Kp32eM8eGHla+Wu/hPkOf3yDrAUwiFp2BjPBaAfgc6l9G6mctW9Lctj4st5l+Uwv+jmF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXhCqp/dJ9ql5aH/D2eZNLm6Pk/HKnm38q65+e3W2xY=;
 b=BJn1TaKc9KoqVqDw5vd4hyAhrO7Qroo0ZwX9nw8sAijojkyRBDx5Yf+k/VJcjSJ5boYcdfmXmSvP9bIxeOKo+YHYQn9RYAywmN53CVpCurrdbUVDPziep093MIErl6HJQ6SJY8kui0uCAHzwMPVPvF2xLhJHiB+dMksWxPmqCCj919ZdOMsiIhAd3zgk3GC2uKqvpT8rwwrDyrvDpCj8cBqpQI4RMHGn/Om/3IipzRqBbEm5jjpfpdwl7y1lQfpuCGOLefs2F0E1D2bzEzEQP8V9T9iKXIrmYdHbjSXuFdbXjhQpVeZh0lcFkarUHQdnc9OiokMeyCr/4t67yUWF+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXhCqp/dJ9ql5aH/D2eZNLm6Pk/HKnm38q65+e3W2xY=;
 b=w76CRZDXMNubAFTSqTvDB+4Pg2NFUHxQSSzOXzgJY5+0+lDks7NjMHBKJQL6CeRgh/LmcuAnkbkHlIVNbG2imnDC/j3GMWny8bLgPQTTLf54z5ZessAQtYIJWDA1CE4CJ7DBRary63Z/8TMbeIuqph+ZITCc/Z/X3t5qcVfX52Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7202.namprd10.prod.outlook.com (2603:10b6:8:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Tue, 9 Apr
 2024 03:33:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 03:33:08 +0000
Message-ID: <dbf70ca4-c834-4c54-a1ed-de553d0ff338@oracle.com>
Date: Tue, 9 Apr 2024 11:33:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] fstests: change how we test for supported raid
 configs
To: Josef Bacik <josef@toxicpanda.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1712346845.git.josef@toxicpanda.com>
 <86703e27bdb8c49950be6ea65ac228ece3ecc315.1712346845.git.josef@toxicpanda.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <86703e27bdb8c49950be6ea65ac228ece3ecc315.1712346845.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::24)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7202:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	q2wch8rYzHKu77biG8p6bV6I5CJEi5PkAjzqs7wRwx6TAZ/NfSPmVCPFkqAaR5wdqCw6hW2gMXznV7C5Lgp71YqxPWyaLzpdvsqNnuA2D7Wy2yxjq+36A4cNpAcRpB2LN854wbSUipCRt5WQ1qDWtCyaVA4cRtU1VfyABH1VFQRBsTGp/tHqNCn4OZRQIUx2WPwH6DBWQutASqAywtbQZf5gG2Jz3UhKn3IownS1ycbifdVMjYbv6BsWyVZcrKO3a9Y+R5oBdRulS4u/1V3pv25GBWxv3kMyoRM80K1tS2iUAKuEm9l0iy8uRQnj3H0zKtgVHQKjO1xzoAEnhOiU/ox4HUuF7vQiR5s4Qsy7Y0WlclxYwbhagLQ0T50Luf9mIoTENd5mRPl9CAY8cDk9rcwhPTmt5cbwV18jlnXldXY+zIeuJU5GD9u3UyQQeXEIqaOQHzH/3Oc3C1cSpAlfbcBRTsnC5L75BIkwVR+E7MFVkN1Pq5NUhGtLiv9tEr3pd3kXiAD4ATfdvRjuJmt0YvS548UzBFXVmk/GX6q6fxitImJ+fRRmhCTR7UJ+IpgvzbFjpuxq6RDlSbx+Fb4EKQZxJdI4JF9Hhtmu/Vc04NbgNQrz2SS72bfzk8UxhVs1uVjszpCVrLQ4MQROSAdXCcE2ZbE782GDfeRfOlLg6tw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YXVEWTZWcUJ2a01MUjZxeVNGa3VsUnpyVWs2aHNtenRhVGJMSEF5bjRlb1Ji?=
 =?utf-8?B?OTNWTGR2TEhOTXcxbjBFd0puNTJpRXBiVFVFTmNxR01yMnFOVTYrNHhvY2M2?=
 =?utf-8?B?Nk5CQy8rK3REU3hyVS9lMXQ1WEg5ZmJ6UTFIaFVVUFNCV0VsUWUwVTJqRG10?=
 =?utf-8?B?L2hUOXFud3dtbVJ0WWppOXIvbUxkVmxUbkZMNXBnSEpLYW5LMVh3Y1I0NkRG?=
 =?utf-8?B?eXpocVlRZzJ0NndVN1MwaEk5RTNzZGtyeVlKeis4dnhkRjF4d2pwUGFYb1BO?=
 =?utf-8?B?dC82VXU5TGRIUVYwdEhURnJRNE1DN1dTZ1dISkUrclc2UEM0bVdUbkIya3Iy?=
 =?utf-8?B?Wjg5ZHZpcTRqVEpKRjJHVERlS1NLQ3BVSkdOY3loQjhsZ1U1SHdFbTFEWGUz?=
 =?utf-8?B?emZXU2lXaUVnRFhNWDRTSlJVRWJwczBqbVgxc0lCamVWQ2pWandrenlUVFhr?=
 =?utf-8?B?djFDWlI0Q0Zndlk2dEZZcUJ1c1BEdkRZd0I3NCtQaWhKaW9zaVgzUlp2Z3Js?=
 =?utf-8?B?Yzk2d2dBQ0ZHTTE4bGd6Yk4xRjJvRUFzblpUK3QwRjRmRGhzc3RiQlZMcGVO?=
 =?utf-8?B?cTZtbWhhbGFIZk9rWXl5K2N6KzY2NHpmY3pvc3hSZXN1VU5jdlk5dGU2R0RG?=
 =?utf-8?B?dDBwTFNqZ2tIQlVzZityQlordi9FUy9tSFpLZXdXbzN4ZjJMcDJwVlM5V1Er?=
 =?utf-8?B?QjdYcnIrV2w3SGhQR0dMNlRtanNDenRPdnpMbTY2OFgxbCs2bHZ4WFZTWGNQ?=
 =?utf-8?B?dTZ4dVpDNkJycllGZFlBUHgvTEJrOCtrR1NVNit6WHZicWdocDBvVmNGRmxZ?=
 =?utf-8?B?QVFJbEZ5ZEdYMUJHS3M4ZUZTWnU2TEFadFNjRmk3TzJ2cFhhdVhvRit0alFk?=
 =?utf-8?B?SXJESTdsNVdlZUt5SnJvclZMYkZocmZIZVJVOHYxanFqenBDS2xieXVDOVVP?=
 =?utf-8?B?ZEFmdGtVbzZxQ3BZTFNaSTB1UHByYVFwNDNVSXN4akJQYWF6L2xkWm9zeXBG?=
 =?utf-8?B?VXJrMnA3MEg4QzVja2hjY3I0UTRaT0d5NGFCVHVoT09Uc0o3YUhWMWtmenZm?=
 =?utf-8?B?QzdCTDFpWUgxMXNzcWJuVHkxV0g0VHpLL2JRT2NPaElhOVBCcFZFd2trSEVH?=
 =?utf-8?B?SWN4M0xGRXpLbGNVSkdBRlN3aElnRHFSZDE0cW5YUkczRG5DK0Yxb1NPYUE0?=
 =?utf-8?B?NGZhcGJFcXJLL2VEVDFHYTVzY0VIRVNRbitzS09GdXcxeVV5WHU3MHU2SFkv?=
 =?utf-8?B?WnJOb3c3dEtrKzMvMDBOeHZ0aHpQSjZkUkl0TUN1ZDBrVUJZZE1ZcGVrQmRM?=
 =?utf-8?B?a0tVZElQaDk2b1RLdUVTd3pQMTFXRDJTcm0vdXNUNWhidFJ3TCs3UnBTMjd5?=
 =?utf-8?B?UkZ3Z0dBQXVxNjJ0c09kL0t3dVlyRzFWT3I0d3VTWWx4K2N4QnVKc21PeWNa?=
 =?utf-8?B?VjFrTTZnNkRsdWQ5elVKellpUEdHbGtVMlVRUGwrcDlSQS90cGxwU3p4NlhI?=
 =?utf-8?B?Mk1WaHl5SHN0eEtsVHdCU2dJTzFxTUhnWld2ZXVhLzhmMGI3VzJ3amh3RGli?=
 =?utf-8?B?T3dGdFlsbzNTSlgweU8xcVhBcXJhZGc0NnpRb1ZwMUhHY1U0WkI4L3p3WU8r?=
 =?utf-8?B?enMvbDdDZVpvanBLaE5CMk01ZGE2QUNxcnhRTEtvQk1KblY0VzgrMGFnSHQy?=
 =?utf-8?B?OXVHQzlWbFUwLzRJc3liYVRsdERvNWJoU1QvTjRHUERsRUFjWFg3d2s1TnVt?=
 =?utf-8?B?V0FKSkVUc1JkVnBjQXJYUVNFL2tjYkVtQjJFL0VrMEdtUW1OVEJXMUhiQWZj?=
 =?utf-8?B?TzBTU2lBRkNneDNnb0c4K2k5RFl3REVObElZa3p3M2JONzJnempOeks1bzQ4?=
 =?utf-8?B?bkFFRXFVdEgxY0I3SzhrY25vUVhybVAwaURGY1dkb2lLcnQ3cnJmb21qeE4x?=
 =?utf-8?B?OVlucHFpVEhqMVZ5U2FWUGx4Zk1xb0Z3bTAzMDdjQXpVdy9nSkRxalZVZFF1?=
 =?utf-8?B?NGNKeXRHVkJYSjJySGN2OW9BTk5qeGJIVldsOGZJRFl3ZGdhc2owaWJUZ1I0?=
 =?utf-8?B?VVZtdDNkVHIzRHorUUhmSmtncTllcEFYeGx0dWIrYytuVGF1NXlxQWdQRnNY?=
 =?utf-8?Q?S2idE8IyDKsDnJtA3UWCCFZdn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NWarjIy7dEAhioSqxPNj8smt+luATQFKiYFpBiKSBSusiM97h/VPgpEXHrAqbV39gZ/uwCNI+/6v1HAhJ1InxiawagFm5vhKZXq6OFxsDBdmuFaK5hcTjryKQnIU6Xmfnm28FOEBtepmERP9MnaxdQaK0oENe0SLdAm4WlWF+1H20NsW+SG8F1UULFcxSzXW1oO1mRYV1rqisMysbxJ5zkqzZ/BGMkg5ceh4Q1lxHAJGqksboGSyg75AsZLkjsguZlmdC8jV1Oz3dGzzquKp/54vhjqZCeXgsEKTmzqmNRfd1WKntIGM+HH277rv8/50wOgXFBc+8pGwtGKnMZ8mO/n5VX2jxJWqs+ndnKpnIb3O2vYaJYBddpp3E+ju1Xni3X5mYmSmIGg58bNHp0JHA5nELo+KkO/rwVhutVMrC4zjyOdV6pdFv9XSqho89ZcB2FR9CL2SUMuEsyO5rQ2Kdo4fNfVTogOFEG0DG3992mlzY1r71VdT6e9a8P4trr9GmeAcIGegzJxC+v+48fxFYcreYoZOGYqmT63ND8sEPFjeNeQ2cGk87DOT87iBqZegZiy1bU2rIWoNB/BUbOsar++XIXegTAlFJ7yCCJ/COYg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6aeb1f-72c7-49fd-82fb-08dc5845c5f2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:33:08.0235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMuLmwGlhVCireW8eB56iWtAenoZb/y0I7KcaiJJOphaizB840mwuoizgrhdFFne3nKwKfn5+oiEkJUmwePJEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090020
X-Proofpoint-GUID: oN0lverqgHzHFJj_3BBd4kNNzG8P8fBO
X-Proofpoint-ORIG-GUID: oN0lverqgHzHFJj_3BBd4kNNzG8P8fBO

On 4/6/24 03:56, Josef Bacik wrote:
> In btrfs there's a few ways we limit the RAID profiles we'll use.  We
> have the raid56 feature that can be compiled out, zoned devices don't
> support certain raid configurations, and you can manually set
> BTRFS_PROFILE_CONFIGS to limit what you're testing.
> 
> To handle all of these different scenarios in the same way, update
> _btrfs_get_profile_configs() to check for RAID56 support and remove it
> if it is not there, and then add _require_btrfs_raid_type and
> _check_btrfs_raid_type to get all the settings and then check if the
> requested raid type is available.
> 
>  From there I've updated all of the existing tests that use
> 
> _require_btrfs_fs_feature raid56
> 
> to use
> 
> _require_btrfs_raid_type <type>
> 
> where appropriate.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   common/btrfs    | 29 ++++++++++++++++++++++++-----
>   tests/btrfs/125 |  2 +-
>   tests/btrfs/148 |  3 ++-
>   tests/btrfs/157 |  2 +-
>   tests/btrfs/158 |  2 +-
>   5 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index e1b29c61..845d01ea 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -98,11 +98,6 @@ _require_btrfs_fs_feature()
>   	modprobe btrfs > /dev/null 2>&1
>   	[ -e /sys/fs/btrfs/features/$feat ] || \
>   		_notrun "Feature $feat not supported by the available btrfs version"
> -
> -	if [ $feat = "raid56" ]; then
> -		# Zoned btrfs only supports SINGLE profile
> -		_require_non_zoned_device "${SCRATCH_DEV}"
> -	fi
>   }
>   
>   _require_btrfs_fs_sysfs()
> @@ -218,6 +213,8 @@ _btrfs_get_profile_configs()
>   		return
>   	fi
>   
> +	modprobe btrfs > /dev/null 2>&1
> +
>   	local unsupported=()
>   	if [ "$1" == "replace" ]; then
>   		# We can't do replace with these profiles because they
> @@ -237,6 +234,14 @@ _btrfs_get_profile_configs()
>   		)
>   	fi
>   
> +	if [ ! -e /sys/fs/btrfs/features/raid56 ]; then
> +		# We don't have raid56 compiled in, remove them
> +		unsupported+=(
> +			"raid5"
> +			"raid6"
> +		)
> +	fi
> +
>   	if _scratch_btrfs_is_zoned; then
>   		# Zoned btrfs only supports SINGLE profile
>   		unsupported+=(
> @@ -792,3 +797,17 @@ _has_btrfs_sysfs_feature_attr()
>   
>   	test -e /sys/fs/btrfs/features/$feature_attr
>   }
> +
> +_check_btrfs_raid_type()
> +{
> +	_btrfs_get_profile_configs
> +	if [[ ! "${_btrfs_profile_configs[@]}" =~ "$1" ]]; then
> +		return 1
> +	fi
> +	return 0
> +}
> +
> +_require_btrfs_raid_type()
> +{
> +	_check_btrfs_raid_type $1 || _notrun "$1 isn't supported by the profile config"
> +}


We also call notrun for zoned devices.
I suggest tweaking the notrun message to:

    _notrun "$1 isn't supported by the profile config or scratch device"

I have made this change and applied it.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand


> diff --git a/tests/btrfs/125 b/tests/btrfs/125
> index 1b6e5d78..d957c139 100755
> --- a/tests/btrfs/125
> +++ b/tests/btrfs/125
> @@ -41,7 +41,7 @@ _supported_fs btrfs
>   _require_scratch_dev_pool 3
>   _test_unmount
>   _require_btrfs_forget_or_module_loadable
> -_require_btrfs_fs_feature raid56
> +_require_btrfs_raid_type raid5
>   
>   _scratch_dev_pool_get 3
>   
> diff --git a/tests/btrfs/148 b/tests/btrfs/148
> index 65a26292..9bbcd8e9 100755
> --- a/tests/btrfs/148
> +++ b/tests/btrfs/148
> @@ -17,7 +17,8 @@ _supported_fs btrfs
>   _require_scratch
>   _require_scratch_dev_pool 4
>   _require_odirect
> -_require_btrfs_fs_feature raid56
> +_require_btrfs_raid_type raid5
> +_require_btrfs_raid_type raid6
>   
>   _scratch_dev_pool_get 4
>   
> diff --git a/tests/btrfs/157 b/tests/btrfs/157
> index 022db511..8441a786 100755
> --- a/tests/btrfs/157
> +++ b/tests/btrfs/157
> @@ -32,7 +32,7 @@ _begin_fstest auto quick raid read_repair
>   _supported_fs btrfs
>   _require_scratch_dev_pool 4
>   _require_btrfs_command inspect-internal dump-tree
> -_require_btrfs_fs_feature raid56
> +_require_btrfs_raid_type raid6
>   
>   get_physical()
>   {
> diff --git a/tests/btrfs/158 b/tests/btrfs/158
> index aa85835a..cd4f604c 100755
> --- a/tests/btrfs/158
> +++ b/tests/btrfs/158
> @@ -24,7 +24,7 @@ _begin_fstest auto quick raid scrub
>   _supported_fs btrfs
>   _require_scratch_dev_pool 4
>   _require_btrfs_command inspect-internal dump-tree
> -_require_btrfs_fs_feature raid56
> +_require_btrfs_raid_type raid5
>   
>   get_physical()
>   {


