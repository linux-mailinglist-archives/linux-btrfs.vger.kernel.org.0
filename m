Return-Path: <linux-btrfs+bounces-2249-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B02684E695
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 18:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D995C1F28E0E
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 17:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C8C81AAA;
	Thu,  8 Feb 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fpPb3kmw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tOUOn0jl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1780058
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412940; cv=fail; b=RSexuB/J1evyVOxM0KYh3S2DejuBgHFQfBv++5TDFc7ffb6PGMCjm8LHS/OWyE8iHgQfP3J0ffTvnVXsG373FaGv2IPAfpp9Hc9vaO8Fl+IftIzfFACyzPylv8kB4OjUiYqlQEBn+30Lq/85F9imZiK3uGFlold/TaTAaevzv2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412940; c=relaxed/simple;
	bh=N4+6EijO0OoQlvnd3bryIS306mzElx0p8e9E4hjGWos=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g/ns4nYpkHojXT6YjG1OVzyZzWsgWAknZNvYbavLOxw/Fca7iCUuQJ9rZb6otXZO7QHeGDA/ZHZeIjqA/RtQyI0zirKWxinNJXCOwLToY5ab6MpRzkMN2EFRVIZRL47TWLMfO9gVyelSBexCZKrzzZVe2a6K5jMcQWdY78+YquU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fpPb3kmw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tOUOn0jl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418ErTBH022151;
	Thu, 8 Feb 2024 17:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=5D0OkyxnMs2ji4yN2yBwcJ9OY7c5Tk9C43t61eH9SrQ=;
 b=fpPb3kmw7yYI27RzzpYCrFqTCjXHLKAKoLMMpN3em5pySxDc5Nn7VgCF/UNh9J2gm/XL
 bUOCGKhS0UnzXgeHFoJVx11tuXJzB3zxkuPQgPYBA72hPrmYrr8Oh1iI9JgfmVSBrU7m
 Ipxn283y/H58zrL8DNQheF9eLmAfwZmV8f0X4DgeFcgyAtV/Z4QCZwCTA8sE859ZtpVr
 S8M22fQL82jfuArIEDcWpH19DGmKCXTK8PJ8trLFhIpOhpbDnI3aUJC1YHqmTgYOpagI
 G6z/Ush4vjkTNJZL2ZClTV2hdgyDXRTfX3cXHB/WPhWiu+lb6A8CMVk4J/E8EC0wle2/ DA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1bwew71c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 17:22:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418GJGm5038311;
	Thu, 8 Feb 2024 17:22:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxasqhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 17:22:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CH3ZZ3tgPfekQc3M9emIqgcpDSBN3lu6qq0Y/L2lYeVAeYvfl6m5enE8TLGworLn2650PLfBTjgxQ9MnFcG5qKUFV3HO3EXwjsh5+RU8R3Jw55w+FqALYHKf5r+kLxXCIyGdRRYbcTl2TtoNrgsKjnVGEw4M8do95p83sUTAlDUwz7aALDw1hIhEUzxr4YvIiO5bJLC7SkqSbR7kWbXzdoRimeHBFSF81HLX9864S8kJAqx8aoZp0e8VFYArLo7ndHjifEwvod/OSrLEy1avAIoUxvRUFb/E/Xq0TGc67NhfysNNWRGWMjPdfaWb5JQjjnPhbEV80S4MIRQ87ZvGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5D0OkyxnMs2ji4yN2yBwcJ9OY7c5Tk9C43t61eH9SrQ=;
 b=cbvcEdbRbaUkz71kwQhbVXOKQ0vzSol6w6Yu6fpAlwyv+ITgkf9B0LVX3p1mKDfjWNVvA9+Ezvy9ep8woGNkY/05Juy5QJw9CAbg9ZI6E8iPuClB4LACbI1YvgAcRFB44ZRzRMxfXNG6piaW1MF5EyXlUsifIZKxmMhKrBmFA4qMVHfqEI+77Fe+sg5sRB4KmdgBi3O7S2z2pZP9AQx7urf75/AO2+Xw3C92Al7gZjux5GozrNXa73TWNCTvGrrrLnlgZVBmLPDC2JNgvglrKTwmrnAr9JS3nvZ7yKq1b7KBPkuK8d8+svEA1/zMmXO/xXmudPBTqkJqZ/C2Z4vu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5D0OkyxnMs2ji4yN2yBwcJ9OY7c5Tk9C43t61eH9SrQ=;
 b=tOUOn0jlNxqGiQjmtm0ciGwFc58b5KDwsNxvHd89pIBf2wSEXS89UKrwNnmok2V/XBQAMU2Bs3OXDtAgb/3jfXWwhBFa3m58MX1H9zxn98XGqGNF8hKq67qxMK+f2gJTSaBQQlfKM/4tb0wYH8q8D0ci0LeBN+KaZ/Vp7w5vusc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6652.namprd10.prod.outlook.com (2603:10b6:510:20b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 17:22:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 17:22:07 +0000
Message-ID: <bb7f33ba-5c8f-4b07-8d79-d0d191ce1fcf@oracle.com>
Date: Thu, 8 Feb 2024 22:52:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not skip re-registration for the mounted device
Content-Language: en-US
To: Alex Romosan <aromosan@gmail.com>
Cc: bernd.feige@gmx.net, dsterba@suse.cz, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <8dd1990114aabb775d4631969f1beabeadaac5b7.1707132247.git.anand.jain@oracle.com>
 <20240205125704.GD355@twin.jikos.cz>
 <e718b759-e597-440f-9fd0-351686bd6b5e@oracle.com>
 <8c326f81-e351-4e71-b724-872701f015ff@oracle.com>
 <CAKLYge+9ngrW-1EffUhyU1y13MzgP33osNDi3D6y6UVW6poJZA@mail.gmail.com>
 <55c879b6-5e6b-4602-b558-e52540b67bda@oracle.com>
 <CAKLYgeJCqu_9aCO+s74rcFh5R6EdLeNwe43MhRmjQ=soFX-rcQ@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAKLYgeJCqu_9aCO+s74rcFh5R6EdLeNwe43MhRmjQ=soFX-rcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 16de408f-188a-4fe6-ee33-08dc28ca79fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oNwLiT4KtP/8VWm4FATpTDrCs6yjrkr29Wr6zmK1H6gO8r1VBVStJOzC9W6S0FWO5qXm5DyQ/y4ZV/Awy7RXGeemxXpTnLaCl4oQo/GTbj74RHYppoRRIIxwMRVhXu1JJ/LE7I5iNpr/B760fluRxE13XPUN6D+EPAScG0/UpASwS+IiJKPk1dKafvf9IXKag8iBjJB9dgDHdiTOb6eBtV8FH2NrAv+Q8HO/FEYJHwWc4Zm9K56BMkX1ovzOLQ4WQ1zIFll/isjM9t+IW18mXSlygrmquWllqC9ySihHmHL6LoKTJ9OBYu/KdCtqMad67rbzjEWGv0bDyHu+oxSOsghLMllKU6e5tClwlSMjVd2NRIV9XFtU/bIr2BXNjNKIrBJ4LrbI6Mi7O813CDXXnws411sGqDnO1ktBD9TrWmZVW+9BhOj7RxeAbGDAQL5TdRg8sgcPLALJdbj2Wu4Hw6iXhkFulq/PfOZgk0RK8Il/hcNmZM5FKNVtIf3JnRcVAXQm5/yFF4Z0D+i/oJtmoEDJrLsF5HqJlLE1fnh30sQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(376002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(36756003)(6486002)(53546011)(6506007)(6666004)(966005)(83380400001)(478600001)(44832011)(2616005)(6512007)(5660300002)(2906002)(66476007)(66556008)(66946007)(4326008)(8936002)(8676002)(316002)(6916009)(86362001)(31696002)(38100700002)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RWdQdFdaUWE1S0NpcmR4aVFJcnBXZGM0NzZLdy95SnlWZk9zR1o3c2QyVjl1?=
 =?utf-8?B?anY2QmlWeGEwL0o5aHNoUTZrdks4S2FNdWNwSnNNWG9qNnZ4a2JlQnFHcU9o?=
 =?utf-8?B?RDlnT0g5TTdzOU1LN1MyRnlCWlF3L2U3K2JnZ3NObCtJajRSUnA2U1BsVW0r?=
 =?utf-8?B?aFhTdkpnd2d5QTlpR3JWYUVYMEZLb2NOUUxWL3NlS0dlVzRBL1dobVg3eHY4?=
 =?utf-8?B?SXdXeWRrdTBORm4vb1NMR202Z0ZpWDd6TVIxU1hOaXBaRVpyZTFFc29wM3Ez?=
 =?utf-8?B?aUxHWWxMR3BTQ2ZlQjNqM1hsTHJSRFBrYVFRamtJcVY4cE83Vyt4cGU2bVk2?=
 =?utf-8?B?elNQUDl2M01lV2FQVUEzV1JnVzdNaVExcHpONGFIWks0cVNlNW9IUDJHb1lE?=
 =?utf-8?B?eWw0elpCYXRXKzBQeU5qSHFySlBJbnlSSnZsSVFaV3FPNWNPY3FzeWpzTlVh?=
 =?utf-8?B?dzlqUzM2ZXVvSjdoZ2o0WE54MXRQNjd6M3Y4NjN1U01JUHVKb3RyMk9NNHpQ?=
 =?utf-8?B?ZGwvZElNVmpFNkc3Q2VQM3hYRlFjanNiaERvb2d3Q0lHQ3dGdURSQ3lVb2Z5?=
 =?utf-8?B?QWJ3V0dkZkovbWI0STV6OVI4L2piZGhnU3hBVG4wT2tkZ2c5ZnE4TDdwTTZh?=
 =?utf-8?B?TzZLMjJ5VXJtYWlVUFVIKzlGc25abWpEUVNsZjlWY21KeHJJS2N5bVEya283?=
 =?utf-8?B?NkFaQkJLZWMwZ0JlcDFJNnZabThrSEdUMVp4QXFDUDU5a285RWM0RFNPWkNi?=
 =?utf-8?B?UHR0SW1sYVo3ZEpWeWJ1SXJvMFdhbHpyUU9JeEtBc0dadzhNZWRrSnRDTDlu?=
 =?utf-8?B?RVVNZlllT2xTZS9NSUtMdE5kRFhBSlRWY2JkRDBTUTRXWXkzNWpIZ2RtMTY0?=
 =?utf-8?B?RDZxL08wWkppTU02MU1obWNvaEU5MzhYOHo3TllTNUpVbldqQ0ZHUmpnck9o?=
 =?utf-8?B?Q3RuWDlNdFMzNU53VXNWTTdtRis5ZFpQY3VHRnlEbnhkbWI0aU84UkZVaDVD?=
 =?utf-8?B?ZjQ0YThxcFZHMk5rbXBkWk1YNHcydG1nRjNDUlczZEFubStyTTVIT3V1emt2?=
 =?utf-8?B?UUQ3bjhzTzVTaHN1SUpCMTBlYmtENG5nWFF5aG5oVWtKWE1lWDcyL2hhd015?=
 =?utf-8?B?cytyZ2o5U1JvL2lFdzNpK0xSeFRicFVhTVdaUzI2bnhCS2YzY21sTHp6REJL?=
 =?utf-8?B?YldnQnFIaU9QNHlzU1lwRE1wNHplTisySzU4cThZZDRVZy9hSytGdlpmZWg1?=
 =?utf-8?B?N0RtOXh5TThackx0OW5PR21oM2ZRRWtXSlhOUVMzb3pQMmd2dGVreVhiNHpZ?=
 =?utf-8?B?ejRBRGJKRnNzTUE1ZjdrNXVCdDZvQmF6Vjc2c1k2a2l3YmtRNXpxbU9uQzky?=
 =?utf-8?B?UkROTlkvaVY2OUxaT1RZK00vWkNxVW5Va1FWY3ZTblp1bUIvaDRTcnAzaGJR?=
 =?utf-8?B?cTdiNDlrOGIrV0NsczNGY0FoOG9ubzJrUE9yL1ZpTk5kZjNwVVBjVTJhZWNG?=
 =?utf-8?B?TmhWbWZvQ1puT3hMOUh4SHNCQ09UNUwvWEZJcTAxSk5zWDRXNmM1UFAxWnhi?=
 =?utf-8?B?R3V0RExaa2ZnajdyQmVnT0U5OVFWeXNkWml3VmQyc0NCOFJHRG91UmlrOHY1?=
 =?utf-8?B?YjkxZW95bm1hc1Q1RnU0V1pWdUVzZGg2S0hIdjNoOU81a2xyb1RGenVvczBS?=
 =?utf-8?B?dC9VL1FnNm51WFVqcThZclpPQzVGSDIyUGNMODVvWmRoZkRyZnJLanZCL2Jt?=
 =?utf-8?B?K28rbWFiSmtlcWo5d0UwY1NHUzMrdzNmdGxIcGlYc3FDUkFyQytMOE83RXpS?=
 =?utf-8?B?UFlPV3RHSVB4cHlzOE9PbVQ3U1d6L0RPeFdOcGNtZ2tFdmhYZ3dJNXRkanh0?=
 =?utf-8?B?L2RZZWRudS9rclFDMDVZRlhHUHh0b0d5UDBZSDhQVTZxcWo1YlFVS0QrZjk0?=
 =?utf-8?B?RnhHWXhBQlBOWDRjUjg3dGkrVUJYMWE2eTlvTHJvaEZOa25nVEE0My9PdW5a?=
 =?utf-8?B?VDdnREQ5aG43Y0IwaVQyUmtJeVI1SXc2N2dSUHZ6azU4ZTN3NlFhVkl4dFkr?=
 =?utf-8?B?c3Nlek16elpPbGVxeklBeGZPaHRscG1VaXBhTEN3eW1yRnhaeWh5RGFxSXNu?=
 =?utf-8?B?dWhaRU01N3VUZ1JIeDMzcHYzMys0bnFjNU9OSHBraUxvaVp5L3IzS0Vxc1lV?=
 =?utf-8?Q?UoRbHn5xyEReeF776WPlsVDurWzXf13BPyVUJqm9eOkQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fIV1yvI+gARLJ2onsM+T8g6ZKDpejq34Qny/bNqNJm1AiQ7Hyj0eNZ6+JYVH6ajzHOIgvYGTU/TfHC2c8I28RUfiYo7rVSF7hNPA44ofZ/3552Ldhtzpg7zcDD6ijVcyzUoPuSw82CZhkbUjTByJ1y+rwgzNbaUVJnkr1p1jn5nSK7iklWnb3zxzTTTBLMPHvtDk2COy6Jkc7U/FNAoXbr8Ep6eZc/KrjhBDVBDHYDY7OJ+BpsXMb7rx4rhh6EFa4MZUPCiAq8tHZnGndMZn9YU5sm0P+hRE9wpvppi2L/0sxZhitI9Ta9+DhjVBjiH5Q8y3hCiY/GCqYz9PtfwnIF9DY0zb9yhiOR1d6CqFz8mSk1rH+nf6r7FUc07IwRtSm6S3l3iZZYBP+d1U5O+UCE7/+wdJ6RKZtg8EFs5SoylbbvFe4ao5WhuJ8GEXWY82oDAC/cC6OiCdBNgccOZ5rd2Y5ZiPQ14dx3kEWobuHh3LYnTDf4rhiGAQritIxNZWGLFB6iBYOqMW8wLqynPwzr+ds0vIf+PUdZlo9JLizh1QZX3RxGDHS3X41B1mkxniMwavkyJllyjjI1AiggZLA4fQSWuuqitBRaV7jWY/f2Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16de408f-188a-4fe6-ee33-08dc28ca79fb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 17:22:07.8364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oiGdm7IlUaibT3P/HT2jEASqS2nn+YjovE5HQyrNpsFmUaIfw1TcB28ySJQWbgdCuto2dBIZMqkrkuchp1n4Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6652
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_07,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080092
X-Proofpoint-ORIG-GUID: Q3tgZu2rwAjqVcEO-HW1lOZ8k8QJ2988
X-Proofpoint-GUID: Q3tgZu2rwAjqVcEO-HW1lOZ8k8QJ2988


Thanks for the kernel messages with debug enabled.

I don't see the message to skip scannaing for
the mounted device. So it's not what we thought
was the issue.

   pr_debug("BTRFS: skip registering single non-seed device %s\n", path);


Based on the assumption above, I have a fix below,
but I doubt its effectiveness.

 
https://patchwork.kernel.org/project/linux-btrfs/patch/8dd1990114aabb775d4631969f1beabeadaac5b7.1707132247.git.anand.jain@oracle.com/

-Anand


On 2/8/24 18:05, Alex Romosan wrote:
> i'm attaching my boot log with 6.8.0-rc3 no fixes and btrfs debug
> enabled (i assume this is what you wanted). update-grub doesn't work.
> there was no patch in your last message. do you want me to try the
> patch you sent on monday? confused
> 
> On Thu, Feb 8, 2024 at 3:23 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>>
>> Alex,
>>
>> Please provide the kernel boot messages with debugging enabled but
>> no fixes applied. Kindly collect these messages after reproducing
>> the problem.
>>
>> We've found issues with the previous fix. Please test this
>> new patch, as it may address the bug. Keep debugging enabled
>> during testing.
>>
>>
>> Thanks ,Anand
>>
>>
>> On 2/7/24 23:48, Alex Romosan wrote:
>>> Which version of the patch are we talking about? Let me know and I’ll
>>> try it with debugging on. I tried David’s patch and it seemed to work (I
>>> just booted into that kernel and ran update-grub) but I’ll try something
>>> else…
>>>
>>> On Wed, Feb 7, 2024 at 19:08 Anand Jain <anand.jain@oracle.com
>>> <mailto:anand.jain@oracle.com>> wrote:
>>>
>>>
>>>
>>>      On 2/7/24 08:08, Anand Jain wrote:
>>>       >
>>>       >
>>>       >
>>>       > On 2/5/24 18:27, David Sterba wrote:
>>>       >> On Mon, Feb 05, 2024 at 07:45:05PM +0800, Anand Jain wrote:
>>>       >>> We skip device registration for a single device. However, we do
>>>      not do
>>>       >>> that if the device is already mounted, as it might be coming in
>>>      again
>>>       >>> for scanning a different path.
>>>       >>>
>>>       >>> This patch is lightly tested; for verification if it fixes.
>>>       >>>
>>>       >>> Signed-off-by: Anand Jain <anand.jain@oracle.com
>>>      <mailto:anand.jain@oracle.com>>
>>>       >>> ---
>>>       >>> I still have some unknowns about the problem. Pls test if this
>>>      fixes
>>>       >>> the problem.
>>>
>>>      Successfully tested with fstests (-g volume) and temp-fsid test cases.
>>>
>>>      Can someone verify if this patch fixes the problem? Also, when problem
>>>      occurs please provide kernel messages with Btrfs debugging support
>>>      option compiled in.
>>>
>>>      Thanks, Anand
>>>
>>>
>>>       >>>
>>>       >>>   fs/btrfs/volumes.c | 44
>>>      ++++++++++++++++++++++++++++++++++----------
>>>       >>>   fs/btrfs/volumes.h |  1 -
>>>       >>>   2 files changed, 34 insertions(+), 11 deletions(-)
>>>       >>>
>>>       >>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>       >>> index 474ab7ed65ea..192c540a650c 100644
>>>       >>> --- a/fs/btrfs/volumes.c
>>>       >>> +++ b/fs/btrfs/volumes.c
>>>       >>> @@ -1299,6 +1299,31 @@ int btrfs_forget_devices(dev_t devt)
>>>       >>>       return ret;
>>>       >>>   }
>>>       >>> +static bool btrfs_skip_registration(struct btrfs_super_block
>>>       >>> *disk_super,
>>>       >>> +                    dev_t devt, bool mount_arg_dev)
>>>       >>> +{
>>>       >>> +    struct btrfs_fs_devices *fs_devices;
>>>       >>> +
>>>       >>> +    list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
>>>       >>> +        struct btrfs_device *device;
>>>       >>> +
>>>       >>> +        mutex_lock(&fs_devices->device_list_mutex);
>>>       >>> +        list_for_each_entry(device, &fs_devices->devices,
>>>      dev_list) {
>>>       >>> +            if (device->devt == devt) {
>>>       >>> +                mutex_unlock(&fs_devices->device_list_mutex);
>>>       >>> +                return false;
>>>       >>> +            }
>>>       >>> +        }
>>>       >>> +        mutex_unlock(&fs_devices->device_list_mutex);
>>>       >>
>>>       >> This is locking and unlocking again before going to
>>>      device_list_add, so
>>>       >> if something changes regarding the registered device then it's
>>>      not up to
>>>       >> date.
>>>       >>
>>>       >
>>>
>>>      We are in the uuid_mutex, a potentially racing thread will have to
>>>      acquire this mutex to delete from the list. So there can't a race.
>>>
>>>
>>>
>>>       > Right. A race might happen, but it is not an issue. At worst, there
>>>       > will be a stale device in the cache, which gets removed or re-used
>>>       > in the next mkfs or mount of the same device.
>>>       >
>>>       > However, this is a rough cut that we need to fix. I am reviewing
>>>       > your approach as well. I'm fine with any fix.
>>>       >
>>>       >
>>>       >>
>>>       >>> +    }
>>>       >>> +
>>>       >>> +    if (!mount_arg_dev && btrfs_super_num_devices(disk_super)
>>>      == 1 &&
>>>       >>> +        !(btrfs_super_flags(disk_super) &
>>>      BTRFS_SUPER_FLAG_SEEDING))
>>>       >>> +        return true;
>>>       >>
>>>       >> The way I implemented it is to check the above conditions as a
>>>       >> prerequisite but leave the heavy work for device_list_add that
>>>      does all
>>>       >> the uuid and device list locking and we are quite sure it
>>>      survives all
>>>       >> the races between scanning and mounts.
>>>       >>
>>>       >
>>>       > Hm. But isn't that the bug we need to fix? That we skipped the device
>>>       > scan thread that wanted to replace the device path from /dev/root to
>>>       > /dev/sdx?
>>>       >
>>>       > And we skipped, because it was not a mount thread
>>>       > (%mount_arg_dev=false), and the device is already mounted and the
>>>       > devt will match?
>>>       >
>>>       > So my fix also checked if devt is a match, then allow it to scan
>>>       > (so that the device path can be updated, such as /dev/root to
>>>      /dev/sdx).
>>>       >
>>>       > To confirm the bug, I asked for the debug kernel messages, I don't
>>>       > this we got it. Also, the existing kernel log shows no such issue.
>>>       >
>>>       >
>>>       >>> +
>>>       >>> +    return false;
>>>       >>> +}
>>>       >>> +
>>>       >>>   /*
>>>       >>>    * Look for a btrfs signature on a device. This may be called
>>>      out
>>>       >>> of the mount path
>>>       >>>    * and we are not allowed to call set_blocksize during the scan.
>>>       >>> The superblock
>>>       >>> @@ -1316,6 +1341,7 @@ struct btrfs_device
>>>       >>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>       >>>       struct btrfs_device *device = NULL;
>>>       >>>       struct bdev_handle *bdev_handle;
>>>       >>>       u64 bytenr, bytenr_orig;
>>>       >>> +    dev_t devt = 0;
>>>       >>>       int ret;
>>>       >>>       lockdep_assert_held(&uuid_mutex);
>>>       >>> @@ -1355,18 +1381,16 @@ struct btrfs_device
>>>       >>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>       >>>           goto error_bdev_put;
>>>       >>>       }
>>>       >>> -    if (!mount_arg_dev && btrfs_super_num_devices(disk_super)
>>>      == 1 &&
>>>       >>> -        !(btrfs_super_flags(disk_super) &
>>>      BTRFS_SUPER_FLAG_SEEDING)) {
>>>       >>> -        dev_t devt;
>>>       >>> +    ret = lookup_bdev(path, &devt);
>>>       >>> +    if (ret)
>>>       >>> +        btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>>>       >>> +               path, ret);
>>>       >>> -        ret = lookup_bdev(path, &devt);
>>>       >>
>>>       >> Do we actually need this check? It was added with the patch
>>>      skipping the
>>>       >> registration, so it's validating the block device but how can we
>>>      pass
>>>       >> something that is not a valid block device?
>>>       >>
>>>       >
>>>       > Do you mean to check if the lookup_bdev() is successful? Hm. It
>>>      should
>>>       > be okay not to check, but we do that consistently in other places.
>>>       >
>>>       >> Besides there's a call to bdev_open_by_path() that in turn does the
>>>       >> lookup_bdev so checking it here is redundant. It's not related
>>>      to the
>>>       >> fix itself but I deleted it in my fix.
>>>       >>
>>>       >
>>>       > Oh no. We need %devt to be set because:
>>>       >
>>>       > It will match if that device is already mounted/scanned.
>>>       > It will also free stale entries.
>>>       >
>>>       > Thx, Anand
>>>       >
>>>       >>> -        if (ret)
>>>       >>> -            btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>>>       >>> -                   path, ret);
>>>       >>> -        else
>>>       >>> +    if (btrfs_skip_registration(disk_super, devt,
>>>      mount_arg_dev)) {
>>>       >>> +        pr_debug("BTRFS: skip registering single non-seed
>>>      device %s\n",
>>>       >>> +              path);
>>>       >>> +        if (devt)
>>>       >>>               btrfs_free_stale_devices(devt, NULL);
>>>       >>> -
>>>       >>> -        pr_debug("BTRFS: skip registering single non-seed device
>>>       >>> %s\n", path);
>>>       >>>           device = NULL;
>>>       >>>           goto free_disk_super;
>>>       >>>       }
>>>

