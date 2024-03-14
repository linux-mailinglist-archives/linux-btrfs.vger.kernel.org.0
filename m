Return-Path: <linux-btrfs+bounces-3271-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C5387BA44
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 10:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8089286F47
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 09:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97436CDB3;
	Thu, 14 Mar 2024 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lhR7IWhE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dc1lr9Nb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE744EEC4;
	Thu, 14 Mar 2024 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408025; cv=fail; b=VnMPaeGd5qtSIfJhAf8w3Y+PIPJVnSRG8IE2ZFenuYxscPwO3PtdPmNTSQa7cbnOqL81SV2FkRMAZI5tTIf7j9hiJuuaJK25sYWIgfWvW44DXheXcjgv8KiNylv2UxSouNd9GYI18rw8TTUQyB0YZ0/hlScYiZszGOTuGqnYdTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408025; c=relaxed/simple;
	bh=LoGEsaD65AhdH8At2ktCCgNmvUDilFc0spR8vlMvF94=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gamH9bjZ2xz1sl+N4JoXz4MqbLWlR5KcgiieGFfxij4db8fD3YbKOtQPdbpEB9KsgthXIyHhJ2pyszQzGrhpmmAHN8RMDc6jSlRsnpTJ3/LcAVW5u0Wk0pw1mpLZMM9iFfm1zngeL6XJkvg5sS9Dw+I3IumKtdo+F29+V87Vs1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lhR7IWhE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dc1lr9Nb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42E7ml5l023400;
	Thu, 14 Mar 2024 09:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zL3/VthPD1KwXb1UUUVqrBdRz9XZyV364ZZlg4vDjnk=;
 b=lhR7IWhEmOQouudXBJOuZVks5g71DpoRy32zZYxpJZx0W5kYJ1NIBoO23FMU6dIAZXI9
 4p3DZIwj7+76jZ1rwThb6P15UeZBY2Evzw9gjY1/8bCpAkXA/q+tvJi0msDxIS3dqL5X
 f0QwaCTW449hhe77gLNIB3wNXSwnDaMTmjxmaKElyv/dljj6x87WOzL6aiECvKrXMwJj
 IEHrt8YpNZbhpOlNOXjjIEmb42rmZVZHdChtlrji/RZlwALWjv6BFoLtm4tFePg856wX
 ki628yhp0HmyGbxsDQ444noPzxErZYkP7YlJbroeZgW78pSr5ZkH1b8p6eNZGkxozvLk 8Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftdk6c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 09:19:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42E89ARh033750;
	Thu, 14 Mar 2024 09:19:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre79tt83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 09:19:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsORTP1HmEj8hWuFZSoBF61sOk83vJAyTruLYpIT6RblRO5I4v7JH9DSE1I5SONYCA77eLeQq1u9E0oYMZ2rSdnsBlvR8CuNrLbbVBq2GkgCU8LsHObaP93393Y8WiKXpQPSzS/La3gyLW2FgJKx7ACwhBpvfY8Dq4W3u1SU+r1LIeGVRC5DkjXqV+RL+3j8Pm8vhScNthtfOAcNH9iQaFq1AHul1cw96n9TJ5PzrWFXVoH397mnuGtSuLZcYfRPmvXtJHFmh7k3ol3h64rO5dJXS1lyTZy/IRP0Hvzhz0eCDAhvUeoGa+R8y/A1GvMzrRa3Hhw9UpoI+PnEIF89Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zL3/VthPD1KwXb1UUUVqrBdRz9XZyV364ZZlg4vDjnk=;
 b=HeKNEdsi5rJOAKhUczafsLyUOmIYBtAw/jcXHDjliZbJXfIBZXeOTScAPr8s0mdl2Ux5arpI0kNLfHqcyNPEVtMXZGnmAW751qJ32z/VFBWhGr3zjksHyZavJwK1Rr7/vjgSmk9YzJj6mTaDshwgZvwu9GmrpfMJTqvub9aMFl4zl+4gbhthVcIrtIcKj9KJT4O5VEbVJvvPxpqH1a7xUhTdPGKevnPD2mWwrOG/SswBmYljNn1WBuL42NrfV1/Ylq+jTArVKIIjCygdvkT9ESjvZWi3rnDCowzAA6HetuN07DZMu4Tgzr5H3ZxdWz9ST5JkbCKMj7knRUR+moqZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zL3/VthPD1KwXb1UUUVqrBdRz9XZyV364ZZlg4vDjnk=;
 b=Dc1lr9NbRfh5wB5Ke0E0ukIrA2HRPcgJfuFwNKP4fp13fIL1c+ZbZbt1CRDARJgq+JAQ2OsJcfPTTBtkA4mPSFElJF1WuW5pgdDq94yUIg2JJXcELT/B989CiiDUUu/5g2deLefGzp2HjiCVeN4urTVg4ttF0ydGr2tbdR5k8oI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6547.namprd10.prod.outlook.com (2603:10b6:806:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 09:19:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 09:19:48 +0000
Message-ID: <d77511bb-cd9c-4217-ab64-71ee96165666@oracle.com>
Date: Thu, 14 Mar 2024 14:49:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/277: specify protocol version 3 for verity send
Content-Language: en-US
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <3528774789271f9e46918f8b1d1461dad0e11cc4.1710373423.git.boris@bur.io>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <3528774789271f9e46918f8b1d1461dad0e11cc4.1710373423.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d54ffc-93c0-43b8-6468-08dc4407e556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+lT+5N3YG9f9I31Xi/mCo4OParUM+Gg50PCah1T83bFC98N5SVspuN/CA/NW3yyVPmF8GXNX7Piv8sOprjQcSZlbwYV3Q3B5702LCscJWkyqLLD7Yhv5TcvJTYSxH04Si2u+VmjzuzKimGaEgQuaAD9ONVAoVRTsgHLu/ZApUuCsiL938nCdz82HTCtR+LCWn92iZFSmkF2TivKLActFOfaofc15kNG36rMiURh55N35gW+cIJyROMbJhUelCnTWeC6nQSR1Kv6OdDfnQDdefBAiL8UEf2P4IzJ26j9OiBdpk3413e/EUeH4Pi4P8xphWi9rcIfAYCO0oRaP2p8tvjSM7NIKzwttNMBq+7cPv+eXWGVR7jaBkw/EqA2bOztEWfVZX11odmkrlDZS2RLyUzCPqa24PJekUHnqhOwbFATrKVYS8SX7JwUYxW5IKha5e/MeCasFiLV5P4TDpfVgUgcPEePtUw1r3Sxvpm8N3y0ZhMP0i0FXyuN2Yu2OdxgJ+Q4n3RnMkBInjtZwfQ3h5GmiptfSnkCkQXYLSCPIQsTyptgrmY4d+s2ulWEjZKbdsD6r7OoA/uD4u7Mj9DQitQ8VPHZ9mvX5ZWpLM+vdJgoGGixlqcrTW1e/J1TUa18PnbRfQgLZ8IrovFD0vdwF8UKSbyNyDpspB9JSQM9bdnY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bVRqZktvUWxqT3htS0dRSWVIRW9nN20rOU5BbVdwSGtUMXJNWkNrQmxodzdL?=
 =?utf-8?B?RldTMWR0ditPelJnSHVhWno0QUVrVmtPWEFjSFlMb3p5SU9GRFpDRjlpbFlY?=
 =?utf-8?B?MnlSL0wwcS9iWEgwVlkwc0hKSjNuVmJwZXRTTTJEaSt6aXBPdFMyNXc3RmRu?=
 =?utf-8?B?WmpBMHlhTFV4ZFQ1bDVmSE9JR0JaWVh1SHNoanVURkNXVDM3U0oxa2NhZktD?=
 =?utf-8?B?MzRiNWVSL0Y3bGxCRitXaU5LdmExaTJxTGpOalR1SjVjWjBWaWdJNjhSbGZ5?=
 =?utf-8?B?N1lNWUpKaks5WE03cGljMElGYzNuUmxMVHN5S0g0TWp6UXRFZjd2cHFnYTNx?=
 =?utf-8?B?Y2dJbUFtM0FiRm42UTlaTkwwcjZTano1R1pYVW1kc3RkQjRoTGNUYkpjeVVm?=
 =?utf-8?B?d0lHUDV1d0dKK0N5ZTlrc09oOTdnMWNJTDVjelJBS1JJZGhCeWVhc3E2SURL?=
 =?utf-8?B?amliN3FmRVBWSGNVWnFLQ1lFcUIxa2oxMWxzQkd1aUlMZXpxYzBzRE9YVUpm?=
 =?utf-8?B?ZDVOS0ptQ0VMckVhRmlrd2ZqbDVXTmZNN0hubjdSemNJaWxwQVBreGNUVGpT?=
 =?utf-8?B?bTVXcDEwKzkvT09iSzA1VDIzV1ZnZ1g1VnlnaldZRXgwQVZVcjF1MGpvTHJK?=
 =?utf-8?B?bDVDeVlmb0FJYTltWGlzUWEzbGU0RXpaWjVOTnpvOWs4S2E5THNTeGhlVkFx?=
 =?utf-8?B?eW9HODl6bjF6UW4rK1cvaFBuWGFSWVRleGRMM3VNbHlzaFJTVVMyeWdaY3dj?=
 =?utf-8?B?SnZ4Rm1kSlBaVkhJYU9mN1NkRERqMlo0OGJPQkRFaHBmOFIwRkNWa3ZGQy9J?=
 =?utf-8?B?SkJTdXUyWWNOZjdpeW14UnBTcFluQ1FFbUVBV1hZMEg2NU1vZVBuaFJqMWov?=
 =?utf-8?B?RUYxVHd4eUN6QnFVeWlsTjZJUTdYdk10ZnZLTmZNWFJLUS9tVXBHYXpFbVdn?=
 =?utf-8?B?dDVYTmNjREpYcHdSTHhWY1o1YStFK3V2SXBiL1BaSVlPczQ0bFI0cnRTdG1M?=
 =?utf-8?B?TjF3VTJHSExMdFJ4RXYwTjNWSjgzQVFjZGxZbUFPVThIb2RHVFhPRnZrV2kv?=
 =?utf-8?B?Snk2RVpUVVUxUzRGcStRMGdNLzFnOVVSMkFlcGViZnkycERlRWJCazQvelc2?=
 =?utf-8?B?dDU5MmM5RlBWb0w5N1RRZHExcm5wTGJSUGwwaGhsNUllUUl0UW1xbG9ubURN?=
 =?utf-8?B?U1llMWsyYkI5emhxWGkzOEhUY3ZEcHg3d1ZMRi9RNU10Y2xCVnkrc3BWNTRm?=
 =?utf-8?B?bG56a2J2amcwajliSTFvelZ4UDkvcGFBei9ucjE0NEU4cjdIS1huUFVMMFBU?=
 =?utf-8?B?NHVzSkZKcVRJVi9sRVMxZm9Bd1RyeTlaZkthaDlLdlJjZUw1TW5JVllCdkRu?=
 =?utf-8?B?WTRGOWlCc1p2RVFGdmQxdmU3RTVacmg0TWFMR2xxQlh0YjJ3QUUzNUljZTgy?=
 =?utf-8?B?a3FzOXpkRVJMYVg4UU9Ia1NrWFVRbS9jZDZBekNDaFdmL3NjNnVWcGIxR2lR?=
 =?utf-8?B?c3VqR2FLdnE1ak5MWE1yRjg1Zjg2ZlVoTnRuUU1ybno1emhLaGNVUElCbHM4?=
 =?utf-8?B?VEZYaHFmQ0tGelBrK0oxQVB1YWUwV21McEdzOG9EbmlKYi9kR1JOVDk0TWN5?=
 =?utf-8?B?ZjJ6d2RxNlRyQUJwbWFOVFNxTzVOcWNRRjNqck1qNUdxWVB4a1FpN1BJZ050?=
 =?utf-8?B?YVFlSFVwQU5FUW5STGtrQUpnZTZHcFpTb21QV0dQQ1h0Yy84RW5kSWNOakVo?=
 =?utf-8?B?bTdQZmxiVGhjd0lOMlZFYWo1Z0c1VTJpRitzakFvL3VSa1lkaytWUWhiYXNq?=
 =?utf-8?B?elVJdUREajVUVGY1Z2EwQzVPSEpDSWRHbjhsdWZrQnpNS2Mzb3p6dVdhWjd5?=
 =?utf-8?B?d0tPNFQ5NFRlazB4UWt1dUJMQk9NdWFaT0VwZHd1Q05ZeG1pbUZFTncwamdn?=
 =?utf-8?B?RWgxaUdycWpZVmlxVlBiZUpXUnhzTG1CdkY2ZGlvOThCck9FOW9vT0llM1pt?=
 =?utf-8?B?SzBPQVpzUmdPNjRSWFRpd0ZKWkpaL2JpY0I3SUtldlNyUGNOWW5SWE5RTnQw?=
 =?utf-8?B?MHc0TmFFbHI0WEtNWklITDNwMnpWSFFRQ2J6LysrVnhLNnROaGFiT2lUeWdI?=
 =?utf-8?Q?ycjoD7oSXI/l+w4jt4DBqUb1M?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZdMYsnOMWSm8whPv4VvUQHZ7s5zLkNK8PTgi2kfsvd9z2ZQNVtA0yaBE/8b0dOZ46jVummEKCOdT6g+SgazmyZXhim1jjyiSO328a+FQWIC2Zr1O0Vtu4oeDO7X7v10Sbzviu5mFj9bq4c9iNTtSLjfZrShxwub2v4wWVP7WQpdVolUMvWj1HxVEvoCmjeN3qO9tiAtwiFaE/wrPbhGI7jMjqH4kXRfIZob500uQ+NU9IyMVf7AEjZfsQv3it8YTXdsQ1kTJ2+L+LlZV4fsSbs47185vb5uKIceAmeh/B2LUCTrb8nICOQkSSwhvdTfRYxLcpniwX+zoJpIQA68u/BsqAqbapozrkxJDTvFalL1rc4zNFLl/Gn3qWNQ0Sd5f3DXRwH5PT+/np4odOocsCN7JqougpqfJMHhDOyM9qsdN7WkLPV/pkoEZEtgLmGEXjjrX0dkzwnBV206EoF+XVw1ELHFEA3++5K5Zox/9cKXUVLqX4JNCez8V2n/e+rySYdIGKH4apBURtkt5MqeSw1fIQ0yqycY7vUTVyMn7FopXDziqYCjvm939y6pdqc3cQuyLR1JZ1OD7OjBqP5P9SJlSL8eoShxuUwcUDZ8dq6g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d54ffc-93c0-43b8-6468-08dc4407e556
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 09:19:48.6015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUW+uOXK/HSEbqE9YXzU8iRVCT4UqVpHoUCugb0JfSA0w4xoncufPUDC7drweZBomUVerQIf5MDsebIq3WENlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_07,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140064
X-Proofpoint-ORIG-GUID: yRKasnv6i8lxXVmGda_FJ2XR7_EPS_e1
X-Proofpoint-GUID: yRKasnv6i8lxXVmGda_FJ2XR7_EPS_e1

On 3/14/24 05:16, Boris Burkov wrote:
> This test uses btrfs send with fs-verity which relies on protocol
> version 3. The default in progs is version 2, so we need to explicitly
> specify the protocol version. Note that the max protocol version in
> progs is also currently broken (not properly gated by EXPERIMENTAL) so
> that needs fixing as well.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   tests/btrfs/277 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/277 b/tests/btrfs/277
> index f5684fde1..3898bda4d 100755
> --- a/tests/btrfs/277
> +++ b/tests/btrfs/277
> @@ -84,7 +84,7 @@ _test_send_verity() {
>   	echo "set subvolume read only"
>   	$BTRFS_UTIL_PROG property set $subv ro true
>   	echo "send subvolume"
> -	$BTRFS_UTIL_PROG send $subv -f $stream -q >> $seqres.full
> +	$BTRFS_UTIL_PROG send $subv -f $stream -q --proto=3 >> $seqres.full
>   
>   	echo "blow away fs"
>   	_scratch_unmount


As of now, the test fails if v3 support isn't in the Send.
Instead, we need to create _require_btrfs_send_v3() to call _notrun().

Thanks, Anand

