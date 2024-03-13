Return-Path: <linux-btrfs+bounces-3255-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A0487AB07
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 17:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7B1283A72
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 16:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A3B482D4;
	Wed, 13 Mar 2024 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NuHy/94V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O8fkkhx2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C3E4AEC6;
	Wed, 13 Mar 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347114; cv=fail; b=VlA2Spplei1O9mfWVcBP3/ayOtcYF3D7wVvFxZV89XarT7WkEmFqIWPidA95CO/DmnKAMUZzaK3w+9hhRp0RNWdJAUPQt9XrV6vXLbg24WFEeZZjiw4tBi5zV1d5cw/1Xg0mhVevWZeOm91Whrsf1+ppFd4iB8UUCkrnvaO2lao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347114; c=relaxed/simple;
	bh=RcQ8S3o3EBeNv+tgBPw2iK4IxK3+ysq61pmjnBNIY6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KP+AArmJbdW5oiddbvk3g1wYOtYrOaZAQhk8eQSnrRzTK26MSdVoyac4ew/+jCty5BFAsymjTONfjFp6UC2qeWinCQCsfqAn9YVZXwc0vAf1YVNRJN4gGuBDDaw4r4n15T/Bq5g93TNGBHmsiVbkJc6w9fje1TMCGLszvakOQUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NuHy/94V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O8fkkhx2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DFwlqI029482;
	Wed, 13 Mar 2024 16:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=bcMcQAwDweZzMxEil+VR6H9HeykMOkwwlvXRFnkXw+I=;
 b=NuHy/94Vd2H6Mkz93tf2CfET7QtSt9rXCA2j3rTg1Rj+GABU7Aqtug3gf1v/0TGIKlDS
 ldMoKihDVvqTBMvewfaR763rg/UsNeE/QE0DpAP0Um1Fq27FxKp1PRxkhKDTI9TDBLji
 RWfGmZ58NrD7g9h255lzNc54JYCRIOlHq/UD8gRhMOY54TGPKsZEWxXR5U4StsN2vgeO
 VQkQv5GGVUn4q3ZHozKVT96CsF2/8eT96Ngo61t6dmxoCbMH+yxlLKIyAcHrVge0ohW/
 QxzLOU8omNJIdwLhH+yvxPjJx9uI+CnjoWOUEK96jk9tu7XPakP3n2WGHMWgO25wsMom 1Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wre6ehcts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 16:24:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42DGDNT0020047;
	Wed, 13 Mar 2024 16:24:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7928b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 16:24:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UI5hmJ0M6BAICh/DeKvpn6KuMsNPrZtD3ZerN4Z1HpkHVQMWUkPJLnhUdZgPkrpEQ8AUxeQyOF659yuNlsYo3qOyyYlfM9/x3PUY7VSzj/kTh5WFCkVxOGmaBGX9rGwb7oYxPrCwGDhcPw5CyvlS90QmxZfPmh8lVZRvb+n1s/fL4XsnwsLgqOooQawXCZwEmXvNoFAAG8cyJi4+sAYrkBY9AqfABI/Zp2lDhViohFSwItqP3ngG1If0F87zpXqqXTxGv4S4gy5ms5cmGjGf7EMHDzY2zazQ3LA9DhCk7wxI6Cp078eZQyZZtKAadO5PUenv7pybEmiV3HZeZT79Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcMcQAwDweZzMxEil+VR6H9HeykMOkwwlvXRFnkXw+I=;
 b=aF0P4hBdbAjmo0qc93HVFYjV1b8QzEx0/rnMQNNNpIpbK7Yfpan3t2LYTQvEhE0vMhjw8N64vr1UXPaf0d+Jk8cmX2wsap3f+EVGE5yXbP/aScQxBl33QUDNBq3pVdJDwn/PtDXtBLISHV+8Wg/4HqWqmFw2hFxsfT8O35ouZdFH3lPDhn6lkHYW/xsvaYI53R4MWun20kZ7WPC1SfQRQZE/MAfMt2Eu5BFtzYu3hKAPqOBbrkgd2NE0mKHOc3nEKhAdIqYMVnxFYjm7rnUe+qkWOyU+uchI0XSak4O1vSCTEudfkZOqTn86NSeM76q6L+wO15/80stD1OfMPCJGZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcMcQAwDweZzMxEil+VR6H9HeykMOkwwlvXRFnkXw+I=;
 b=O8fkkhx2IfNbp4GG3AB2rzmXizJ3RnoPEreaT92BtFPDV+XW3StDl7AGpPKYYzGMtWO7ii5w3Ha+ALBIFTlE5UtWvU3xRwl/0vZK9XtaSAYQpUBkNWCcKqyfQ7vYxJ4FdHXZIsNKeQ5ZLvWPF/KJKs8MiVpmWN6X6q2uVARoyC0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB4945.namprd10.prod.outlook.com (2603:10b6:208:324::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Wed, 13 Mar
 2024 16:24:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 16:24:55 +0000
Message-ID: <98793bfe-6751-4862-8877-412013723e49@oracle.com>
Date: Wed, 13 Mar 2024 21:54:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: validate device maj:min during open
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org, stable@vger.kernel.org,
        Boris Burkov <boris@bur.io>
References: <845dfb4fbf36dae204020c6a0a0e027cab42bcf0.1709865032.git.anand.jain@oracle.com>
 <ZeszQwa8721XnZsY@infradead.org>
 <be3571d7-2bfe-4bad-b2c6-84a0bf121140@oracle.com>
 <Zes4i3qvFk2nWjyY@infradead.org>
 <9a59cfac-2ab4-4c6c-933a-70dcd3e3d80b@oracle.com>
 <ZetJqJH-K-fC-pC-@infradead.org> <20240308173254.GA2469063@zen.localdomain>
 <ZetOIKNJRsdFNJ3A@infradead.org> <20240308175133.GA2470614@zen.localdomain>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240308175133.GA2470614@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: d20db32a-7981-4ce7-7893-08dc437a1e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yPfjVRsMpnONKiXZjnyRPo7yI7KBxPtmiqZEYRKScqP0pNvmf11TBCGL44cuc5rZOpdx+qr4l7p9NtkCtIhLm+VLh8+ePfDE+145xXXEWYZCO8dUwLuqD6C0PnUwKJKjiRYXkRvKPOlJ7pK29Q/wy5tQC/Ndp+zkhl6nN1jprP7WacyqvqggtuTgWxwMHc7u9BH+jwLTe+G+fQSuRnXMZsPBgVUChrqw75sSh8vceVqnFkkYRgYYQVS/eJlQ0h+0paiJTgYlgUp79vvh5J+wOnDbchk5vJ+/WuUovown7zHQ5gpEuVS52nV3o4gOgsZ85BxaC/0OoMWwfgaCN3MSgQhazlbKAjAxhetZd9TSOwFqrpcKlfYaNKhTHxstb4bo612XkX1Cpcq8BTb7NJ2IXt1FnP6wO08TStKSKogN0EZkZz3bK21pOnVl9HM1cSFaCiruq6saIeceH/+PwRUHnPQQf+5CH2rE1SgZlCzs8ee6WBRxBBH+CMwgJmpZy19A+gKbFq+Lvs/1drSP8g0Io7x3QCVP+a6a4gujtoJ6GwXNM0x5Pe28nzQFcETN2RZKiLZRkbGKqOtqB4+K6W2BphzKPsMAeez8DyIV4ht7PPlV9LH6D69ew4TduVDchi1N0k6on1K0oUxUjdeAXnn+3t8aYRWBxLKOaZw8E6OWEYI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ak9yWHBPbUVzZDV5bWhVN01naG9tT04rVFVZeE1zSmRrRWdVZFp4d0NCbGtO?=
 =?utf-8?B?RWJ4QkxTY010SE5DbnBkSGF6VXo3TDhPMFBRSnIyT0gxTFJ0b2hpNXZYRld5?=
 =?utf-8?B?NUc5eSt0akNibGhKLzRFVTl6UVF4MzYzZkdGNUNiV091TUhBb1Z4Q1dDdm12?=
 =?utf-8?B?SmVXZzF3dGZSNlBrZlQxU3hBaUdNc1RmbWQxSW5UWHV4L1BYMGc4VHUweWhm?=
 =?utf-8?B?S05vS25kOVNHVlpkdDJoMmMvWC83U0E5aXR4WFZzVDNlcy9jNmp6WXNYOEVV?=
 =?utf-8?B?MUhvVXBRNnVNY1BOcmUrQzdjOVNxWTVwdlI5L1VzYXdGelBIMlkydnREMmI5?=
 =?utf-8?B?Sk8wNHVEa0pMREFNQWZlbUVvVTJzTytUbnFrdGVFNkpoeURpQjVaS1NJRTA2?=
 =?utf-8?B?TXlDY3Brb3UzWVVMTGdNbjBpR2V4N1JMUFI5Qmx5MVBlQzRXUnZpd0FJQW1D?=
 =?utf-8?B?LzV4bjhlb3FEYlZ5UXdvSXBLcm9rcTJHcWw2eHJGUXNPL0Z3R29IQWpCYUtM?=
 =?utf-8?B?RjNQRWJMQWlzRUJKOVBuRzBkVXBCTTBudU80bk0zSUszNGVUaFZKamQzZkNr?=
 =?utf-8?B?TGU2R2JUVFIxVEpaTlNrMW1QRkFBc1FuOGp3TTVlQXJmNHl0VFZrcDhraVNa?=
 =?utf-8?B?bmxSdHRzcmhFZVlMcVEvWC9ZZU1NY2tJbG15VTZyUXpvbnQ5NFNUNFQyNjll?=
 =?utf-8?B?UmxvWU9FQ0dYa3FINzM3WXFKYUlRbDRUVGtVMk1NOG9wRDRLc29hNW9Ua2V3?=
 =?utf-8?B?d3A5b1hpVm4zRWY0K05sTnhIUmNYNVFnQ3ppUTVnL29zOFhhbUIvQldRdmN4?=
 =?utf-8?B?K0hCZGhxczJ6ZnUvbzdUdDNiblNMdE9sTDdtcE1iSzUrb2ZiVHpVMVZwbG1U?=
 =?utf-8?B?UGlnV0FaUkNiVXVGQ05xMTY2TEI3VzFZK3NuY2JVRkh0T1Q2SFAwREtwOUJY?=
 =?utf-8?B?UVlVMHQ1K3pTUWlXM3I3K1V6ZW1tcjcvME40NGFEaEluL1V2dU9pdytqTEQ4?=
 =?utf-8?B?RnM0ZlE5MW0ySzJLTkI5S1BIWmJSMU54UGkyU3lKYnR2YUpvL214UkhPS0N6?=
 =?utf-8?B?aXFXWXJnNVB2NXJtWW1PdXFuSUh3OTFTa3JhNzZ1eG9ZRXZXeUV3R0tqcU5x?=
 =?utf-8?B?MG5VdlcwdFFSdTE0ZG84YkdNSmVrTktXY0Nkdkl2bUxxRnNiSlZOODh0ZlNP?=
 =?utf-8?B?YTdiZVFsTW11ZWFTRUlMcVpzYU8zQUNKS084K2lacFRXTE9pcnhxOUJGaDE1?=
 =?utf-8?B?U2ZrdlFZZHVDa1NGVDVJSWM3Ym8wVDNmcG1ydkNlcXBFdElIcVJ3S215QU1Z?=
 =?utf-8?B?TlhaQkhlREpKN0FsOVFzRGIrNzJEcFo0VVNsZlViZEhHcko0OHpoK2pWKzR1?=
 =?utf-8?B?bWRYcGRjNmdpTFRrSEQzU0g0VklBcXZkQ2VnUE5ya0pjcHVvUTRmS2txa2ZP?=
 =?utf-8?B?RWZsYjdtM25zZGhGTk9Ob3ptN1Y4T2o5bDRwdUV6QjVMODY0Rk84TGNhaW5t?=
 =?utf-8?B?cmhZcm96TnduNXd3SFkzSitlRUhtRk9acDQrM0p0OTZ6bUFDTXBReVBpSmJE?=
 =?utf-8?B?anhaR0JNVmFTWDNHd2xLNzZ1dkxOaXduSXJzak1MVjBpNy80VW9ybkRwRDNM?=
 =?utf-8?B?Zll3bXExdkdJNnlod2RrR0I1ZUpLZzVSRkludEZtSFdwUWRKTkpWOXN3blFx?=
 =?utf-8?B?c1I2R3pEU2FiVDM4MHBKWEs2NFc0NEZ4dDE2MXJxZUhON0QvT0JPUEo4R1lZ?=
 =?utf-8?B?NmFzN3V0dEZzdnhqSWI0QWRQQVZGVDVuRHl2K1JJMmhEQkhaRXNyZDVKOGJC?=
 =?utf-8?B?UW1YdmN5MDQ0TTlKamF6TXhKZTBqTkx4R2xqWHNHczh5V0RCWms1NDkyNUl6?=
 =?utf-8?B?ZU91N09KVEgvc3M0Z3czYU92Rjc3YmlNVGtoMUk2dnBIUXl1UG9heGVXQmxx?=
 =?utf-8?B?clVFWHNZZFRFR0pjQ0RmY2dkNVJoWjE1QWFmSmI5dVRoc2xqeDlESnlhN3Nh?=
 =?utf-8?B?aVlTUFBwRVNKMnZla1ZTY0lWZGR3M0dubFpyemFKay9EUFdJKzlWMG9FRWlW?=
 =?utf-8?B?amFjSXhVQ20rVGtLQVFsRGRjaXNXMDVKclpPS2RaMEdNUzFZOWg0K0ZXNEJu?=
 =?utf-8?B?a3l2UHRkTmdlcU0zUUV0QUpTNjZGakNaeFYrRFBnYUVvcnRXRnVwSzAzSjlY?=
 =?utf-8?Q?6428hvyucBy16l+81WaUzld1wU7sc0WHuS1RlrXmKxgP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+dp3VIBvQQw88LoB6k3jSpX3zR75rGRZPq9PKWHa/R1SYSzfLLcQfLRH1+bsJT244SD+ok4wTYDEamCSFvwGpLfW5az60EvqxBGcz9T09gqoao0A46XGjKJkuvX8yvSvt8dfICQY3EWn/NUX4Ff7d9IE4tEpcujwscPZ843s1FWuTvB5VXQr5CRnIta9aFKF59WZZCgoimuawTU/aLgtsyT1iA5GMYJwwOafVkr/UkRQgU7Zqnq3So8btofyTqlKC66SpqLnrqtLsqGNGJbLB0EJfbARJcTqkH8HDaKXIEpud0ucBkEnS2WxcmdxraFFDPtyqGM/CmfppTvU3X75xKMmb9o9ylA+rQnt4tOuuRBoHpDYY8qY6RU0NeujzeCgPC7kM92koY9uB4vqZ4kkCPDXuD7pXuSicmGNd0jJl3zYEj/qkgB5bF7eO2xT5SL2T5GZnh31EA7xaXZvk3Qby7MeNX9EiSmNUK+RzXYaBLsL8YPvW4NN156xKMgvANE43Jo25bbT1brPnPklJiCgWoRqLThQzAzGmlMDLYL3Rp13OyZxzivdD+NCZ5NClRRF+24my7ykMMRwt5qhd7Ex5z9Y0TWV2vBf4dVRjiihlp4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20db32a-7981-4ce7-7893-08dc437a1e33
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 16:24:55.4801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZL39KYa+DWWMOYpK8uvEB4F2INMgwdf8pr5UZznT4xmQQKId/7orAq8IIb+xEqQ2tQbwIFcrZWUiLk2GFvl9ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4945
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403130124
X-Proofpoint-GUID: _tb5-Qs4XPNvnXqatYUerYG5l4dSBCdR
X-Proofpoint-ORIG-GUID: _tb5-Qs4XPNvnXqatYUerYG5l4dSBCdR

On 3/8/24 23:21, Boris Burkov wrote:
> On Fri, Mar 08, 2024 at 09:42:56AM -0800, Christoph Hellwig wrote:
>> On Fri, Mar 08, 2024 at 09:32:54AM -0800, Boris Burkov wrote:
>>> You remove/add the device in a way that results in a new bd_dev while
>>> the filesystem is unmounted but btrfs is still caching the struct
>>> btrfs_device. When we unmount a multi-device fs, we don't clear the
>>> device cache, since we need it to remount with just one device name
>>> later.
>>>
>>> The mechanism I used for getting a different bd_dev was partitioning two
>>> different devices in two different orders.
>>
>> Ok, so we have a btrfs_device without a bdev around, which seems a bit
>> dangerous.  

The 'btrfs_device' without a 'bdev' is just a hint for assembly in the
kernel, with validation occurring before 'bdev' is saved. Hence, it's
not clear how this could be dangerous.

>> Also relying on the dev_t for any kind of device identify
>> seems very dangerous.  

dev_t is used as the device identity for the tempfsid feature. In the
case of two cloned single devices, the fsid + UUID + devid will match,
but they will differ by their dev_t. Therefore, the tempfsid feature
will mount them separately, assigning a temporary fsid (in memory only)
to one of the latter mounting device.

However, in the mount thread, if the dev_t also matches, it is
a subvol mount.

The actual use case for tempfsid is from the Steam Deck, where two
identical images created by disk dump are simultaneously mounted on
the host for validation. Ext4 supports cloned device mounting.


>> Aren't there per-device UUIDs or similar
>> identifiers that are actually reliabe and can be used instead of the
>> dev_t?


In this use case, when cloning the entire disk, the per-device UUID
also gets copied/duplicated. Using special clone tools to update
the device UUID will result in non-identical images, making them
unsuitable for the use case.

Thanks, Anand

>>
> 
> I was led to believe this wasn't possible while still actually
> implementing temp_fsid. But now that I think of it again, I am less sure.
> You could imagine them having identical images except a device uuid and the
> code being smart enough to handle that.
> 
> Maybe Anand can explain why that wouldn't work :)


