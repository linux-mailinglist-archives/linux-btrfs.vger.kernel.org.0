Return-Path: <linux-btrfs+bounces-2959-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2268486D94C
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 02:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB067B21F32
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 01:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AAA38DFA;
	Fri,  1 Mar 2024 01:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PM7WgufO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Sz4qz7Lz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779892B9C1
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Mar 2024 01:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709258382; cv=fail; b=EHBRS19raqQlQWV2+/qvA7hPZVA1ZnUAt26max+Y4NuQPmyFUDyPx99Pj6d0SToVrzexJItLIVC5M0GVurTnCdj6hPb+HiwsahMvrtInS5OM5lnGe0wlnCfxtDaPMuzgulCfnopZfkBJ5kVYQUEgxjI5X8dmp9b2rCUhh6T/a20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709258382; c=relaxed/simple;
	bh=5Dn38Os3EIzUNa7fx0N0dxyJ1VnuOkzRUn/8icGb18Y=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ghV5Hko2ol0nQNEhfht42XnuYX1hjTCh1d0rCSnpW/CtTnFj3xciTo9PVr545Q5NmyyKJ5ich7JokQbK5PyKfiLG4cjB3M5M2VyRMofcGJ9Ke0DQtve9uiBe+siC0FlZSwNc4cSNEfbHdewhMD0zcW+IWvbSSrO6kkMq//h7WGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PM7WgufO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Sz4qz7Lz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4210idSA000680;
	Fri, 1 Mar 2024 01:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=tAFxGlQ+52ojFQ5AQZbU7GsL2r32deyJmigyf5A0lks=;
 b=PM7WgufO2FyRe5SvjzH1X6vsw4cedJ8mUO55NPUxqpEj/NO5RG+490dY3knVQBfoj4W2
 46sPsKqwMggA4jwVrVaOprwSMbwMoZkM1tivzX2IeQHclnLWdDoi0RUSqO3tPCvD0dSE
 1wIgJ/E7ontt9f3Kw5q3zQAuzJNQ95kSA/3LaIgWOKopc9zybaqQ5Ui4rqqe4oUBlrwq
 U5vQpWGTO3Zyp/pND2vGNeNxCtT5yg5mfQ8S39BmjWoK+MY5GmyfE7IQkevakqrAB+oZ
 aiKrBRjG/n4LNulpgb+hfMoK4IAZo/hFWHSM9/xeic/41IfkUcC58+Miwl8NxJaAGsQZ sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82ueupr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 01:59:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4210Xg4L005746;
	Fri, 1 Mar 2024 01:59:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wjrrbbbgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 01:59:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BT4AoLFwl2v/dJz3c3JgddXASaKWjpbSUvjPLXV59XbUDHsLRLbow7+FxwIfjkM/LwF/v7k2dEHYYtLfuYvVwPDTDPGsPyf0Py20aUhZgODoF5/qOtRHxeVnaUY5K8RXDcN0Pf6HjDHo8K2utR1EsMV3Hk67atGEHeBW8immZdyEiYJT70Oq8ziKc8lGiqw5HQck3afxjia+qTn63wNswgU7iax9cHYpXH9qUWHjajXcHLerMWp5YOkvbrfusQYS7m2OyCAxAhInaBKkp/XSdRqlEv2PZlnihhsJRddkN5mdze7UNXdb7/0P3x/+90Ywp03Aaa1y7Oq+IHRKoNA2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAFxGlQ+52ojFQ5AQZbU7GsL2r32deyJmigyf5A0lks=;
 b=BXnwtw+VvTrxtjgDF6r2V1tWfIsSmPzIV9enJJay+ABspnDEiHvshMZVxDnUQAXpq33LpIQ7lwXjJ+20o8wGtF4bfd7TwsuZx0nDOkV+Wlhs475eL9NGPvzk+ubdpPBY2q9/mmZVIwVth66mK9VALf9+7xONhGteYR5PzeRmjCPAZ/+jbxAvuyH3RcfFTOHCT5VuuvEZyPSOeK6PYeLzY4dGcFU3cAhbaVwk2Bn3Rg0o8Len9+u2BLl5KxRnr3VlMHI3ZQILk07yAEi3iUZ7y1q2jbAL6SgD4i/Yv+27Jma0eFOGglybQn2SmPcr7BDDgG5gEeFZSE9h3/ySg3JL5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAFxGlQ+52ojFQ5AQZbU7GsL2r32deyJmigyf5A0lks=;
 b=Sz4qz7Lz7sn0m8+R42wWoh3iMLLahadm8BzmW1uiGOcbX9lqa2qAJmd/3kydlxDHJ5QX5o+xcWanH+wgyv/7DZsgNAxKjWCi8yefeC2LCs2FcMYdzSZRWH4Vl5w8LMbmKLs0D2Z473VTeD3a/Z+MVtdpT2iPffUXMeEjACmRUI8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 01:59:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Fri, 1 Mar 2024
 01:59:34 +0000
Message-ID: <ba2a72f3-e41e-4a9a-b45f-0ce18724a961@oracle.com>
Date: Fri, 1 Mar 2024 07:29:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: warn on wrong dev_t in fs_devices cache
Content-Language: en-US
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <c07bfcf1ca8ec66b8cfd1c6afae0b755af655cd1.1709251888.git.boris@bur.io>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c07bfcf1ca8ec66b8cfd1c6afae0b755af655cd1.1709251888.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::32) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e179d8c-7f05-4def-5744-08dc39933e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iThAVqaoemwP+Zkw0xwFN8QWm5JyGCXjZR+XI3g8rzhVJxA/cQM0ZDNllZ5GCm7yN+O8vakrIYHAaixkQIWztVD8l/qo/nPazcdt729knfVD9zy2I26SNYAwnlcAM76VwYqPh/znj7yuAHlgeV04u1xEJo44gKAN/iYgQq1RUVk4ze2bb+zXY7v4l1vcdpo2o2FDkvYdzCZFsyCWqOrOtrYOjLrJgItZ1mcsFzpjfIZrGuP5bW+fA4Nh+DJb5+DS1o+xDufBXe8H0Noh3LwHRrOKFBbG3czjvMLq/wKWbdClIa3qtxtOuDcFA9QYVjcACQmx56d1R2SobtQXkkKMYI0OCYPl3mPk5XsMOKYvebBM4QgdUnYeFwe+ggUFfObx0/dSWsLQZqtPh4G/ABFno3aduqS/70mq/7CtXAVjeK2/CB+KDHg0Y9vrz5AzKvbYFCg5OM1K/dFwuj4T36LGLMOwT77uF2EPfmIz69xapvLynBrjxUgRomqEmBJj0DAe4x2RxdDSynjq1TY4woXGEjr6KnEjhUhTQkgn5kUynif6O2xv1TfK3AmVMsFWMRevSmACLfxQP3MF8lFEFPnaaRaI8b1UMuK6r1kfaEJmNJ6nUHnizPSSkJNW0+qxA0mf
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R0llN25lOEZPalo2R1dNUWFaUkZPc0ZGMHRWSUpjby92OEhQTGhqNlVPR2NT?=
 =?utf-8?B?QzVycmNYcE1jOVY2dE1ZNjBPN0JYSmVFMmZlaDVMU3lUWUh6bGhxbE5QTkFS?=
 =?utf-8?B?VGZaM0pYcWJtRm9xbGpkc2tzRTA4S2pPVTFIdUM5RzVXb0w2S2dWQ2gzNE1L?=
 =?utf-8?B?OGNBRC93S1lUSzNuVlFhbVowUDN5S2c1eTR6UzRZQ0luT0M0WnhTYUxKUnNQ?=
 =?utf-8?B?LzUwVDlERzFzbk1ib1RxenpiUUNCS3NRWnN4cU92bW5pU0hHLzJEWFBkbEVN?=
 =?utf-8?B?TGFGQmVLQ0ZTRHMxbjdJS0ZKdGZjNk82M0hJdXh1cnFka2hzK1ZIWlNhOWpm?=
 =?utf-8?B?dnF1ZXlvcXR0NFQyRHBBZmQxZXpIeEs3NVM3TVhSZC9nVFFIMWJJZ2tuN3RM?=
 =?utf-8?B?VXRxTmlxRGRBNlNkZzFUQ0UxL2lDYXFGTjQxMHBudzlDNDdFc0FOeDVRV1Nu?=
 =?utf-8?B?VlZyT3dpeUVHQ1h5djZkOTVBL0xPdkMzWWtaSmFVdE02SUFHZHVDUUk3ejNp?=
 =?utf-8?B?SjY3MEdvc085Mnl6VU9UZEt1cHlpVTh2OW5TQ1JJRXAxVGRIR0ROTmE1U3NW?=
 =?utf-8?B?cHRLK0FMSFpyeWZNT1lRemZiVW94YkQ5N3EvTmtsOHlWWnE0U1IzODNNZURo?=
 =?utf-8?B?aXFkNDl2cUxjNHcxa1RCdjhjT1hEQng0T3J2S0xPamxRVGIrQzRDYjVtYUx3?=
 =?utf-8?B?bXZReHFzKy9PWUJkcFBHY05DMXdTS3kvQk5vYlhDNmdFejlFSllxODFKZ1JF?=
 =?utf-8?B?NGJZSlJlRnY0ZUJSVEpMeGR4SDE1V2JLM3NDcCtqcDkxcTFIU2RuTmZ2ampT?=
 =?utf-8?B?cTBOa1VpeXJlOFZsWVVpbk5iT3BMeUowSEd3RTlsZ0U2cnQ1dTMvcGFaM0Rm?=
 =?utf-8?B?dExhUHFwNDdaeFBxdjZpOTBoa2ZDZ1kxcENTUnpyVFBtWHdURE5GNlFpVDM4?=
 =?utf-8?B?RDJNSGhnQVRxQUNxbW9LbDAyMXlRNjk0ZzJsUm5mS0ZrZDc3ODhaaisxdHBQ?=
 =?utf-8?B?UTV4Mkk0VnRXMVIzVXVrb1VSNG5oa0lIR0tQUGVrOFBudEtRcm95bHNyQzFw?=
 =?utf-8?B?TWF0dTNralAwUTFqM2dEV1QwclRwMHkvdVNvb2x6QUNNVUN4cHQrTSt4cjlh?=
 =?utf-8?B?TlEzNXFNLzg5YlBRNldRbTlWM2d4U2hUU0FtelEra0ZiWGVQZFk4cVlpSGU1?=
 =?utf-8?B?dlNEMWM5ZTVzQVcwRXNzZm9lNmE4bGFDM3JGVlpTRGhVaGZQcDdmNFAwVXlr?=
 =?utf-8?B?RE51NFNKcGlPdllLWVZVOUk1OUdUTVZVaktlT0lPT3lJZkdFQ2RTQlVJZjB6?=
 =?utf-8?B?M2NVbTVyUzRrSkdTYThIMzhZczRkSk5jTFVHR2hncGp0N0diTDBLcnI5ZytF?=
 =?utf-8?B?WnV1Tjc1dEVOK0dDTGVpUFVIdFNUbFJ5L0N4MkJOMnN6dG1GNmxjWk1tVzAv?=
 =?utf-8?B?aE5tTU5DanFCekxCVUkzbnFjZE5ZQkdCdlVqVEZreEFTYVpocE55dUFRM3ZL?=
 =?utf-8?B?OWx0cFQ2bElxeDJxMWRJUlBhZjlsOFRwYU5mbGxncEhXOVUrak9mMVg2cGdS?=
 =?utf-8?B?c2VxMlpEdFdKczhVcHFiWlRSdVpacWkzK0ovYUNrZmF1UHgyRVJOK2g3WXFO?=
 =?utf-8?B?dXprZTZWKzdkYkJHTFlqdVZDTHpDbVgvaldUQndjc2h0TlA1WTZ1aUtEVHBD?=
 =?utf-8?B?MVUyN3RpaWdockJmWmVScm9RdzcyeHNvcURJU0JvRGx1T1ZaZURhSTBzczZV?=
 =?utf-8?B?VXlkZVlxd0ZYL3R0SmwzTk1EaE8rTHYyQzZxY0pXR1JQWEUrL0FqdW5PVjFi?=
 =?utf-8?B?L3c3YktPRnZwLzd6WWxPMDJBUmFhMHBiaW05QlBkL1NiK0pTcFNSSHhIV0ZP?=
 =?utf-8?B?b1B3MHRnalk3Q1FFb1VuOE9JWFRQeUVJYnpzUUhDeW13ZXI0NlJFbTIrNzkr?=
 =?utf-8?B?bUY5YS9ZU2t3eTJQZEQxVUFiOVZoU2dteUtqa3IvME4xaldLRHV0Nnp5SGtE?=
 =?utf-8?B?cEdySXVtdWFpdDgwNHB0NlgvRDVjcjExaHp2WnBFRFZnamNiNmlVdTIzK1Fm?=
 =?utf-8?B?VEpiOFFFbGg1KzdJYnErUW5PZFdBeklPa0ZsSDdHMDBQQi9vT2RMejY5RmpN?=
 =?utf-8?B?M2pmOGxPWXZWUkdLRy9UZXJMNklKdDIvb0VLMElGaFp5aExyQTY5UElzK2x0?=
 =?utf-8?Q?0iV+vV2D0OQTOxPh7I/RJkj4zPewZbly/DuMOcfvThX2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/1vn3pTF91ExNUMrzDWatXxi4lbPzBgHdoA6c+9J7aJE1cWtcnV38mzGcDzwdr8BZfe48WR7CcCMI8pQsYRAWhYMStfKZRcP/v4tRVQ5CYHWXptEBMZcQ/poIvQ3Hyfq1twk1fnJnPTnXOKmvEyQqQl/pr/nz9UvpqQY0/xerkCrrAfOdPRIqqlqKG/MUDesPDwStGHwH2DR91SYlEolszTuW/XnKy5V9/Gv1TbuDfn95vSJPbyoHIxulAxAwLKTxVAeq1LoBacbzw9u7azEOnnJsJw2zlo9eTsWKC8siWXizawSNVlycRc7Al9PtuIL+QRDKy+Yc+JIV04IQITonOajuI8KP5W8XckcUUxoHbsaD/vfPkwgbmvHwzCDjrWfm5gADclg0dQZgOIRLfPknRd/Syc9QW0KGN0CoQ48qFgSPVlpO5WB5cpqMHfGIy882u6OemMcWYE4cfg8sb65OmlW5gBJ0P+InF3oTiXMeXpjjDY0q32MgTCkkSiaepCgiCq0UBZQ9gR8+fp92+eX+DjG6tbUSZaOS0MaBjvCcq6ZIFgKau8b/w8wU8JBa1IfXCCFxAmxV46/2iaHuq/xVN49Gd0Wby4iePVKeOIPuWo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e179d8c-7f05-4def-5744-08dc39933e19
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 01:59:34.7938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnm2HpiOKBUt0zoQqLVDsP2gXXXK2sPZvxUKBI4Ke3Zh9MqADH8qOE3zq7/15vrRbNheJYnqz/9eqtVMHjcFUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_08,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010015
X-Proofpoint-GUID: 68UyjFQKgx8TlqssfTiKvQFW2i33YpLz
X-Proofpoint-ORIG-GUID: 68UyjFQKgx8TlqssfTiKvQFW2i33YpLz

On 3/1/24 05:41, Boris Burkov wrote:
> We are trying to close up loopholes that can cause this, but until we
> are sure they are gone, this feels like a good precaution.
> 
> There are lots of ways the device scanning code can end up masking this
> condition in a way that doesn't immediately bite us, but could be a
> timebomb for the future. Try to make it more obviously a problem by
> WARNing on it.

Not exactly a warning, but we can fix it. And,
we don't need the btrfs-progs patch. I have
sent a patch for it.

   [PATCH] btrfs: validate device maj:min during open

Thanks, Anand


> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/volumes.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 3cc947a42116..0d81ec3cadf6 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -690,6 +690,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>   
>   	device->bdev_handle = bdev_handle;
>   	device->bdev = bdev_handle->bdev;
> +	WARN_ON(device->devt != device->bdev->bd_dev);
>   	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>   
>   	fs_devices->open_devices++;


