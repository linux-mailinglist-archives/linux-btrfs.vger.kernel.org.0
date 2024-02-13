Return-Path: <linux-btrfs+bounces-2351-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829228531E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 14:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B4D28B251
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 13:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A4855C3D;
	Tue, 13 Feb 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ga7wD+0A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q+tmr7sn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F1E55C15
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830951; cv=fail; b=BkJLXWOnDBQGTCG9WsP5nmnlRXR0B9EFAYeKQMzUjVZ8umuAE+qIamQRFn7GOC9AQWQe+9tUIVkpgVJxVYbrCZInTin0jo1M1pRbrib+prsZ2c2GcnrLuKSlZjO2PP/6QJXb0t559182BYYEPkCrYBygdNvIUl6FpNK/kznIGT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830951; c=relaxed/simple;
	bh=yINeSo/xvWU/TXKi0ZTQ9W1bPh53VVU0KOkRRAo0kRg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WsbJL6QSG3ulVswK28q6lgZhJVXllveBhAfDU2t5DO6Mz8RmY1lXWaFjqTuv05o6TuIBsU0GOo4Y95BZ8AgX79XejtPqZCBqP1BZQBBMBhXFpzthOr0KryFL/vP6IHyLEKnaDWtB/iQFLYQ2nNKHbMm5xdoW1MCbgzfl7oUDPIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ga7wD+0A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q+tmr7sn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DCx8kK005260;
	Tue, 13 Feb 2024 13:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=j8NBfQ6LQcb/VIm63zPZv+dGCL5r4y3W19ejR9peKWI=;
 b=ga7wD+0AUBVR20vGY35BM5WGkODYRPOtG9xcOUqAYeMQ8JF1xvcjcJNpHy2IkaW60tU2
 zELpQdUhbAXTI2yyRztUztkjvPP27Tsb6OdVUaUrkCG3mTZomTMskhglYJPrVfQb++0s
 vh8qmmnsqBJsb9fgN39DEizfBTIJLRTvcE7tQgfywofpf0B4cuHnV8KcJt41gUY1qc7R
 CGQ0dcXMjCCAQQtCV4MQ/OgV7yfkrtbhb3JqpAQ+Kqc86VS8FkT3nJkZrorxCPe8ZGrg
 ylKAflJlzkCBP41hYOEX3DlGy/988LkV+EWwnF/LP9HqNcQUridVwX7OZCwqLaFDU6cI zQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w88wn02h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 13:28:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DCFCZx014946;
	Tue, 13 Feb 2024 13:28:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk72jsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 13:28:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTHfZL/uAXj2VU30bkaL5MI8gz6JoMTRpcYxMJUxDcn78IrzpruBIwF6TVNGGOe92veLAJCkWIK3v5ypHkSuIpd/pX8yG4cLk6IkVybylquiRCzNxVaqkwvfhu9T44dc9jfKvWwOlct3/J5aZiWfZcaz/D+wfjftVZz/AoElRHhNKQpChn5iCYbiM/y/GzBga434P6z35KHWaYTu9aELitTSBvtIkeSPKAbldsGzbpPY5WRIKb6KSAuIlzXYpYmcXV8jburxOF5cE1nHhyW+ZAo+WwFE0yYcu8nyeVxHYcCd2LN/XUPG65y1Pffc4a2b4DWR5Q2KKh2xn8AlwtoEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8NBfQ6LQcb/VIm63zPZv+dGCL5r4y3W19ejR9peKWI=;
 b=EPQAHP/pFVRiY9tskrz2YVNqfPOLbXrRzHi/SYKxFwYDBlmUzYOxqDdXdZ+xF2+adY1ab/tCBzNTdy7JMqSyMaUIAgdUJ93+Q9GS2Afq8aXjaZ+chitePBPn4CwoYtzbK6LSaWORouiF6GcREVakwkz+QsJ4txXNkEnYkHeCByOt/Yt8vHKiZ/rRqwqO5QUqDVnwucbsgaimQWcFwTAUASC66d48HBgtFhbXvss0nk4fhcgzXBg8v6Ujnoky1JAXzaJ+eiv/SNYf1hz1Zl61GdhkCuSXqCdF6fpILqc1I5QyKU+aA7/2PfPEfCkL3vXilj5iJaZi8bAoPionY5G4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8NBfQ6LQcb/VIm63zPZv+dGCL5r4y3W19ejR9peKWI=;
 b=Q+tmr7sncWrAorM5MMW7rFTfy6zztbmwrenlWhgClLn1RHTztHCA9Azj/EAeqjUvMP8BuZWf6Y35C/L+ao+fcQHqDTkIlkeew07oqrQVoe3n5YEEE61fHnfetEuTtrnhVPdglJc0qkhijphCiG3eLrMOmnDZjAIFd8dX08T8INg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 13:28:44 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 13:28:44 +0000
Message-ID: <a9743c70-4c60-44b0-a4e8-3878a0c551f2@oracle.com>
Date: Tue, 13 Feb 2024 18:58:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: sysfs: Drop unnecessary double logical negation in
 acl_show()
Content-Language: en-US
To: Neal Gompa <neal@gompa.dev>, linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Davide Cavalca <davide@cavalca.name>
References: <20240212013449.1933655-1-neal@gompa.dev>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240212013449.1933655-1-neal@gompa.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: da2ca74a-505d-4149-ba9a-08dc2c97b335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dov0sqId5n5V8NZTQOakGNTx/thDQ39B3h6PipZUC0y9ArSk5TI8vrSJD2or6SPFfDWDMATJ713s6BpyQiZslIcv+ZgL/uAtvj4SFbrlyG8LQVTa0P78V2fSYXpq+Zb3IJAlDKsJHsGkj8sr7pZ8fL+oRNIT2tkRj3VEDRfuCM2LCMP7CS0iieVAIKqu7TZGo3Rd37IUUy5NZx1ZTyauaFUP42xpWgB5PiuWL0uWpbQPbb7JPRP/6/aRvCptZ7A2eesgqnoAzRGce2YtCT4GOXmWIi3uHqiFj04jtAcigU7DbCTug1wy8/jgw0upTMT+PQ8LcnrkiWQ46Fv3ee3bIOsWXkfEb7aioa0u8+V7WhZTr0HFVhK4xOB90p/pH5uG7ysUdFb2BDCtq2/wjoDZ4WnZqbJqaCPIb8JkEgqMn33NMXsIZ02LydXiYzYISmHct8moaXzzRJBKE1jQPu6bUqAPhGXhE7yfKlNZOnkZAFW0iiT5Q2jw0nVsFRRh7p1jk1FhnYpPaQ0IyJmB3BUYex4oJ0v47OPv5FjGWmpqe/OHVROqfRhUVqIKDsjPicsW
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(31686004)(4744005)(44832011)(2616005)(478600001)(41300700001)(83380400001)(26005)(5660300002)(66946007)(4326008)(66476007)(8936002)(8676002)(66556008)(53546011)(36756003)(31696002)(54906003)(6512007)(6506007)(6486002)(6666004)(316002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dTZBM205UmVqOEdIMFVHdDNyZkpBcFdac1NmS1FkZEdwWGtxMFFNMUFlYW50?=
 =?utf-8?B?cUpoVTgvTlhEUFlFYTRTUzg5UUdLQk9IWWxxeU9SNGd1MFpFNm0zdFVrQXBH?=
 =?utf-8?B?cUE4VFpIL3Z1Mlh6UW5UblM4SzRzL0lKOTZYVnkxWlIxRUs2ZE1GRllSSzZr?=
 =?utf-8?B?Q1A4c0V6aTB2UXI2SzEyR21XRG9DcWtnQ2hYWUF0YW1MTk5xUGtyQTVBL21Z?=
 =?utf-8?B?OUhWUEJ1RXZwaGFYYXlEZi9hcFhNajNoQjFkb1ZvUkRMenVlcmVEQlFPRHcr?=
 =?utf-8?B?cEZxU0NNb1N6em5wVlFVY1c3OVRjbDZSM256NGVDMTJOK0l2Zmtqa1IvSk04?=
 =?utf-8?B?N2M1b3dpVHRLL3BFM1pTVWxmODU5SVBjaTArOVpoNWJrVjVsWHlFVWtKclZj?=
 =?utf-8?B?YWhIaWJ6bVJma0dKR0FML0VKeGs1aHBueVVvNnlEeVBIVjlCd0x2SzY0STBU?=
 =?utf-8?B?OWZoZGs1NDFTYUY4UmpETEVwU2RJei9iSGw5aGVzZWgwMktHaWhkM0NkVTh4?=
 =?utf-8?B?U2pzUWF5TkFPelRCamk4M1cwWkV6N2NldzIwbEZ3L2J5RWsxZDc3bjkyR2dY?=
 =?utf-8?B?QUFETDZob0w4T2thcTZldHZlWDVPZm41d3hEeFNxYjcvdkREb0o0bDJ4UkQ3?=
 =?utf-8?B?R2Z2a0w0cDl5TmdwSkhra3gwTnJ5YmpzR3grczlxWVBmVEo1OUgwemZaUWNw?=
 =?utf-8?B?NkZwWndnVlVzTmJvQWpEU09zSlZxK3hVelJKSnJTOHZFMHQ4dWtVazdnRDlK?=
 =?utf-8?B?Mk8vTWxhZmdCN2FFMm1BZGxpalJaL3VBRWc0Z0dDVWFSVmhjS3FnNUg0Qldl?=
 =?utf-8?B?djBFUGducmhteGtaZmMvem5ZS0kwRzlnWUJFVnM2cFp1Wjl4TzUwT2xmeU5s?=
 =?utf-8?B?MVU5dU1yRzUvRXJIalJPU1UvYjRlSGlPMnZaek1kSUpBT3AxSVZNajBEWXdm?=
 =?utf-8?B?ejFiUXdlVTlEbzdDTFpBNGhZZHFSUkFtZGdnZmo5SE9NSU0wS3Y2cWtXallE?=
 =?utf-8?B?UkVPOGU0MUVkTWxpSE5hbTdocVNsNzQvY1AvTU1MWm11YnJlZkhjRVVCampn?=
 =?utf-8?B?a280cDBxbEE2eUFVcjUyT2c5alVBNXVJQ0tTbGxTTmVxVFlZbnNnRjJXb1ps?=
 =?utf-8?B?T1M1aTUyQmdGL1BOYnhTZldvM0JTRGZ6cytFanV1NEEwd2dzUDVxcy9aeXZy?=
 =?utf-8?B?cnVkanFVYXNYeHJmRUp3TVNxRUtPbkoxN0l0STA1TWo4NU50Vlc0ZWFYU0ZP?=
 =?utf-8?B?cjhXRkdCWUR3QnhoU1VMR25XQWRySlIwakNFYjZsZVd0dWt4OFdqeFJIQW16?=
 =?utf-8?B?cndSRUNBMVc4WTNpejlISllLR1BxOFNZMU5ZbkxaOWhZSVFXMXdRYndoVE9q?=
 =?utf-8?B?QTYxakxoYnZpNTFzL0RjV2paSlNkRUYzV1N2dFNrOUlLbDVyVE54eXF2aHB0?=
 =?utf-8?B?NHAzY0pxQnNHZGpieTFkU1NjNDRyMDBsNkhFTWJYdW1HWTNQV3RvTHlCTmE1?=
 =?utf-8?B?RHl4ejhKUVprMWk5WGVFU2pINXNadTFKMlRUMjg0Qi9Xd3NTR2NOeGFhOXl5?=
 =?utf-8?B?TjRnRFlMQzBUbVJHdmZ0bXIyankwT3ZKd2Fnbld1bXl5Ny9malJXNkdxK2Fa?=
 =?utf-8?B?OWpQRnFRM0VFNFlpRWJ2L0lvWkdUSlliRzFsK3ByWlVhWE5nd3lKUzg5bnR1?=
 =?utf-8?B?eTh4MU1FRGJxc0J4ZVpwMjkwbHNPU2VsNTlrT1E4WDJ1RXMzNlFFNmRCOVc0?=
 =?utf-8?B?S203elRWVXQydkU3RldnbitOOWNWSzAyTG4wWHVRQjRCdXV1UEszckZPc2Fy?=
 =?utf-8?B?ckV6elAyR3EyM0dHcUVzdkJtWDJ2dSs5VG5SRi9rZ1RhK0tuQUZCV1NJbVQ5?=
 =?utf-8?B?SFZ5a0NMMjh3Qll4QTNHRUp6bmp4c2VsaWhFdHJCbi8wb1AwVHFRblNUNjhE?=
 =?utf-8?B?aHJBRGg2bUwrKzIzWUZjZXFtKzlndVpQVGpvdFRzTWZyQjY4QkRycmUvbmtK?=
 =?utf-8?B?OWlGK0J4aHJnaWp6ajd2MFM5RE11dS9DbWZLZEtsQ2k2QkxzRTZpaiszQkZt?=
 =?utf-8?B?RnB1WGVCdmx2dkpvUE9VWGNKdTZpWHNzbGs3OXdmcHU3ajdEeUtLQ05aOXNZ?=
 =?utf-8?Q?T4ikw04Frlt1N/SJaEy5RexDs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mtdUkGTIkHDDPLxAKmas6fR8lNftEHRsAM/ceTop3er28NW+NS54AUJ2Xzf6Cc2YqKXqK8zYIA0GXknb4dxNUeVRPBqxu2t/XA0MvqEka/Q4PugsdRygfDgZE+QbfInpv9GFljh5H9n9jWLO10nyZ0PpO059vo4ykEQKULfSWp9KyC6qVwimNPDxD0BYSSfsW3Jpj5cZEtsHCDbzk1REREwwWlJAYZDzj10o+MnbiaHA5Gg97WVY02uKjI5ttHgX3hiK9PHpqbm566bcGJO7J1MC2SC67OdbZp83kObmdJpX4/XQenKvPIXHKtq0hUHSngkvsyg7yJYs4SGjygXqWJx5+YNSXjBV5Pr6nHqMp+pMGeJBW8RgmC9ncWDCmOVJJQ0VyALxtRZercLvEu2qV2wyaJ6Bagv9cS3o1/UQiAcv125MHmD2BEK/iIXYLlUm5w+aYwlnz7JxPcEE8kBE3OJoSwvfI6AfGqj0gdt5TLGhudZU7oVRip15a2iRNDZtBR8h+z0SKamptmTv6t+hGIT9vp4hsVOZGWwCTLfXVlTZwinCqEs4hxOHGS9uUjyem7YAga9Ipt0S3JjWiFZKiJg1VBzuPSjsynrKe0Gl4i8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2ca74a-505d-4149-ba9a-08dc2c97b335
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 13:28:44.2102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4KTesxcYwr2yooLse56Vy1uL2Dq/civX0cck8pf7oRQdxnyUV7RzDlaC84uxeCIdrGY+cK1HJUPXhhw8zZI2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_07,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130107
X-Proofpoint-GUID: 0fBl3E4tddrHMCG3jXxe3Q21cLJwzQbx
X-Proofpoint-ORIG-GUID: 0fBl3E4tddrHMCG3jXxe3Q21cLJwzQbx

On 2/12/24 07:04, Neal Gompa wrote:
> The IS_ENABLED() macro already guarantees the result will be a
> suitable boolean return value ("1" for enabled, and "0" for disabled).
> 
> Thus, it seems that the "!!" used right before is unnecessary, since
> it is a double negation.
> 
> Dropping it should not result in any functional changes.
> 
> Signed-off-by: Neal Gompa <neal@gompa.dev>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


