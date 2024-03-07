Return-Path: <linux-btrfs+bounces-3072-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DE38753E7
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 17:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506841F25B5B
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 16:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD7712FB00;
	Thu,  7 Mar 2024 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kkARkymF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e2qrA4Za"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696F112F59B;
	Thu,  7 Mar 2024 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827749; cv=fail; b=IxxvHG2M+2rzXWXLOhrhQixYCb8PGCHZQs0U43qvu0Ak9/WapNSyepSY7UB8DtOK0w5x+cIhEWDso1KGMJB1k51Sffa773zQZxShUiEUqG5l7AV97CwDcwxH23txHsfINbFOpmrYUYPdLYXsLIQ6+s2NGcrTspn3tpcJe2DcJzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827749; c=relaxed/simple;
	bh=CuhQVGFlhmqKJKd3C5/55blK9bQHmXNStszqaJBCM5I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XDNv+Kd8IqQuMEYV3EaZUf5a/++prBcID0RVgNgRjw1jsZJRJAETsqN3RSYYITEs7GEq0qjuzRcLgx4oTyiwdjERKrrF7E16+d5Ij8CdlWmB/kNV0jONZ6Yuvf9YDKjM1BMHPoWJOJsdR5ORFv0utV1rkEMT63o6EqBcmeqVcVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kkARkymF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e2qrA4Za; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427DTM1t009248;
	Thu, 7 Mar 2024 16:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=YchtmITpMTwhQYC3B2d7S46bmGc6IJzbLs0Zafz/Ces=;
 b=kkARkymF9mj3LHeMpT1F1ovimeUS6aEnL/8gTiag6upg0TE4P7Ppc28l+9T1T8psGqIi
 0FCNZA4s9un8pLyx7I3HvvaqJs040kudWQwxsbRR/QvHlw0h0owh4TdU3O7MG6IZvcif
 xvEHa7mCJUMaDye0Xvc1Rj/+5BITKYhCJ3ZA+3B7Yi+V5/ClyYwXRnZf8qkaB9NtJTh2
 S/O1xQeD0De3jasgJ81iYvgA//tG76r+YdyI4r/gtaG9AcJz52f9EcvLeeA3DwLdsdli
 E2OtEYVYkc8v0R9JwlnFzChGMQExyd+gjH6OiMV8wDTztWoi1J3PfkusLp3x/Lo4AXMI VQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkthemnqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 16:08:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427FeKc8040825;
	Thu, 7 Mar 2024 16:08:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjh6msp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 16:08:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obw0dkLgmcYMnN0sd9flZ+9XxdoQ+E+RDuMBpnvHncl3YVAgp0czzhZOsbUlFldWxnR+TRWey3MmgYfkAeaNbzTkQeQ0NTIDus5uljr2rIzC2fQ2J9DfELPfJvngVDHQrsXkbqM+TG27chHCz0/A6IdLCajaDDEqrxQSlWbqurQxGsB04BO8AqjEO9R0ViL76cLht0mTX6w44TK2+h43SlldcJ39mPTrOiS/T95SxU+2TF6EBwI7q2rLb9RFvQS0rkXfbNbg5pVWiE+7k2jKk3MdQtRaJXIp8zpB3d7A1xuN7QFKyzTuY96NN3MblEqAYkBGrVTuOFvnJbiv3ZrKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YchtmITpMTwhQYC3B2d7S46bmGc6IJzbLs0Zafz/Ces=;
 b=ZTiY5I2bqp67jvrT68glryhnlPXR4I00QLIfTA/sgQz/QJJcnuXvAiSC27Pz7L7KaDqKLCaIjryYY9Cg0Ha2Q8WHYxChU9dmK5pHrh5OfI1YySisgTQLMaNi5+u6PZA6QNbKcTnVK9vmuGcq7ox6wHYeDtbHWcvyxX08G1O0OgbAN/ULSR2QM2lHLj47ax5Xpt7Ei13JXwy2iLggdkCcwgvxO2xlYYD9nGn1HFqYcAoqNdqdfpJRghIqoBRZH4w/KsSbXIipa0jdgyJ8v3vHGEmNPNzGI1PYttIf8NeMj6NlnysamS3KIn571VKlXYaayL57f9CgcoPia1BfWDVqmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YchtmITpMTwhQYC3B2d7S46bmGc6IJzbLs0Zafz/Ces=;
 b=e2qrA4ZaoTt8kfqeiSKxJlQYc1Mq5XLK/jx5JW8781XsqX+JK1ACHuR53owPpBjICVrSHD/Xfpb4PUcRlY0GtiB8LtgpPTUEA/1COFpzho4bLyWNEn8fIn5LGiq2rwJavu0/ZV7+cszz3s/2kcoVnHGbua/5kXrjkReUaKJ/h0E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6370.namprd10.prod.outlook.com (2603:10b6:303:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 16:08:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 16:08:36 +0000
Message-ID: <55157ee6-c21d-448e-88ab-87a3ea99be66@oracle.com>
Date: Thu, 7 Mar 2024 21:38:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] common/rc: specify required device size
Content-Language: en-US
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1709806478.git.anand.jain@oracle.com>
 <c74dc3a6f1dc8d45bc54ef6ac087e5e92a778509.1709806478.git.anand.jain@oracle.com>
 <20240307151622.warzurzdxovxh2gn@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240307151622.warzurzdxovxh2gn@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 876ceb4c-a194-4bd9-2ce1-08dc3ec0d802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8rMtgusRrjdwaF4AV06zlpv90id2Br9PRTzZU+Zq0HuhmiBEVfhJhS1aP5n0yy3xU0+pir9JaR66oPSFmo8p39LJsBmlaDDvkibrmbHScDIovoN7JK7lBOw225j5oy2Bev7Tsl4UR6fqpKN52aFlTlwb7/oBi6Yx9AWN3qHiKugrcY0VRaS+Lx0yRgTaY07JQ9wJ/RBKu/DNLF+9UYgyw0eKMwuOOlyRg2iNAwo8Vfemb5N2+xXl3q+lZ3HW3fZGuu26ByE1cSIm65X+y3VjBb4l1/1v7GN5iz8fpJitYbUenCL7I7ubBkPlFZ8l55mHtnw/hsKyTsKkXwsEpJzUnrGmqIm/Wf9FR6lpocUeuFHKH61ZtSFGA8LOuogcahbiWs945QXzMK0LSbnDIiOvB3IPFLPDiX+194kch1B3sUJa2H+laB0E4ypF07W5jV7fVnBwBUIZW483S2QuxGP8uZknpJGgPPzygVKMn0YaQ1IHbgiNB1ussGulsa77sNF/gsqOJyM2el5DKbAKLuHIEB6zYHfoVdtDHt7AH7kWj4M+qbh+slxwiVCn6O6HC4R+SnFjBay2ts3zXBwy5UFabM1Q3YlMU5AzPO6DQ4BN+nhZ/pfurpDKLmgUAneEF5u5qseZfoaG2FrmEGt8ufxdzU3U9/4ZYv1iP5XbaWWuzaA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RkpmRmNIVFdnUVo5eDZEMllIU2UzSlRjRDhIUS9TUFJQbnFOVmlkeWNmSXhy?=
 =?utf-8?B?bDBDYTNFT0lWT2pITmpPTFNTTHBHQnQraXZGcTc5RUFQL2gzQzBsbnZjTTRY?=
 =?utf-8?B?YTNtcUd5SUFhb3hHaG1yL1FYYi9mMmFwSUVZaXhERDQ5ZmZVOWVSemZmWFNm?=
 =?utf-8?B?Ly9jSHBJYzk3MExRRXNxMXNGY0RLZ28xUGNDcktDMzhZTVRQNGFZdnpUVU9T?=
 =?utf-8?B?ZTE5L1k2Vlp0Wm5uY3QrV2tRT3RSZ00rTERVWng0UHRYY0lXUmdUUWc5R2pv?=
 =?utf-8?B?K1RLcE11KzdMYXRtWjR3b3FCYmcwdFAvRGU5SHlhcFBLNU94MmNVWFhhTUh4?=
 =?utf-8?B?K2ExOFV4ZEpKaVo5UU5oc2xrcDh1NUhCRzBZTFlsMXdyN1hrY244cjVhUmlD?=
 =?utf-8?B?d3RzRWR1M1JtaHFTZ29qbUQzdE50ZFpvTkJla0liZk1WcGJ4aFhkM0ZxSmdq?=
 =?utf-8?B?RnZyeEpGWUZOMzdTV3F0QVVRczk4aEo4L0RhUnJ2eFRqK2RMcG1ZcFFkRjBQ?=
 =?utf-8?B?eklDMmxlZ0RKN0JVVUlJWFRJK3lJeFRHZ1pNd0Z3Zk5RYkU1V29pNkxnakQw?=
 =?utf-8?B?bE5GU0RuWGdqWUhnQ3o0ZU55ZSt5T2p4bEFEbEtWNlpyRUFjVUlYQ2k3cWpT?=
 =?utf-8?B?MU1HNklxbG5CWkY0dHViLzNQSFFFRmk1ZkhVa0QxS2F1ck9Oais3L3JjQVRI?=
 =?utf-8?B?eG5DbnVoSk5YYSs1ZnNmRC9aWmc5NGFJMFFyNVdCWFBFaW1BdFZZNDBpbEZQ?=
 =?utf-8?B?S2ppUTBvVHVacXMxOGRVdTZMcER4U0FIUE53cXVDeVJCSXVQU2RwamZpYUZT?=
 =?utf-8?B?ZEhsWVRTQ2o3VG5JYnlzV0pKeGhPNzBRY3lKUGxUc3FoeWJBeVdNMllHRjdS?=
 =?utf-8?B?TTlMZGdWbjNsRnZiaXFHU1QvcDh5WEt2bmx6U2ttbXBZbHA5aThodzdLclcw?=
 =?utf-8?B?SDNiWGhMVU80OWlldy9yVXBNbkZIMlJRUlRraEVCZ1VaU0hJakVlUWZWUVhh?=
 =?utf-8?B?TzBSaU1OR1NCOEVOYmZ1cnFhcjdqWU9wVzN3U0NjYkhaN0JKaTEvSUJNUG10?=
 =?utf-8?B?TlVyVnlueEZJSXg0blJFeWtlOSs4VmIrR1NKZFRBdXpOdnYxNzZlQXV4OGNw?=
 =?utf-8?B?TVhhMTRCanhkR2NHdHVyLzRTOWhpalNRbWdkRWNJWmVNQS9vSEtLRVBRcUd3?=
 =?utf-8?B?UFNBWlhSTUQyQU5JUHgraExGdnB4VlJlbjNkUEZEMVBqSllxWmxTeGphVFFE?=
 =?utf-8?B?cnVKbjkwVDhRZTd4ZGx3OFBJUVljdU1ZSXBVWVJZYmZBNFZJZEg2RjEzR3p5?=
 =?utf-8?B?WWZtTWFmSzV4bk5sbzBFbVZacHJyQUtNbCt0MDhtdERzQnNldmhBNkJISWhC?=
 =?utf-8?B?QzNqVDhFYmdhQWlzUkRlSGZVRVkwU2xmNDQrM2FxUWQrR2xzMEcyTHg0NnRr?=
 =?utf-8?B?REowcGRrazZCUll4NGhoa3VWRzc5RG84Vk82ZnY4Y1FNSExwN3FtKy81eml6?=
 =?utf-8?B?VnN6cVBRcS80b0NJKzl3Ynd5M3RSZm1tSEk0TzYyOFp1NmMyc2tONERJamty?=
 =?utf-8?B?SmFJTXZQWjg4emVndUQ4RVpnZkdUZ0YyMVg1MjUwMFlBSERTYUZITFptMHll?=
 =?utf-8?B?N0JQdk44Zk84V3VmYjhnamY4RHlzallaaUdNS09qdXdVY2JRejJBWU1rREhw?=
 =?utf-8?B?c25qdERuaklockE0QjFXS01ibzBWMmpMSnRqKzVCNWlURVh6NnFiRTlURWhR?=
 =?utf-8?B?amJ5UnlSc0NKb2JWYXZrOWt4d0tOT0szUHlNakRKWTNVT3hHWkt5UmdDQU5B?=
 =?utf-8?B?bHo5dTZ1MGZCdjlLRHRwNW1aaGxYaFlYL1hEMkh2ZFlJZVJWVHN1V1VqTFIr?=
 =?utf-8?B?WVl4Z0tPdm51TWJvRWYwcVp2SFhVUENHTmIzMUlZekQzT0h5ZG92ZVV4NWd4?=
 =?utf-8?B?clNjc3o1dWRSL0g5SlNnYVBPUzQyTzFJQ01WSWhOWFNGKzU2WG0wSXVJcWZ2?=
 =?utf-8?B?aVpFNFdWNVBsTi9DWW5xTFVIcllqOWNiOEhRMkJSYXV0aTJJa0JMa1d4NFFm?=
 =?utf-8?B?OEpqY0ZRMUNGRndCMmFnSURNOXFCUWZ2RlRiUUtHb241anJHV0FaTGtUQlEy?=
 =?utf-8?Q?es4TW85hlc2NPvfFbJMQmIghX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Htno1GgG58ogsiUf91bleaYR5GKNp0hRP6ruzNkOtmDNO17VZN1z4E0ZmNos3c0GoW6M4Vo3p7yYJj2NtUxHEDy3hvcASWF231ny+OmsWjFuhJJ4tzk8Lupdr4G/ViO1yMLRuz3/Xg8+osZTOTrZ/c/bpP4Kq7gMXTJ6osCIPeCAuyvAbFrJkMYYdQ7sIpiojP8z4uZ6hQSt2gOxM99t74IDIp4yOTqmi2m8T8oSi9J8W7y7f6DokIeGE4+uuGn8QmofIahw1Dj6kejWrCgPFsDuqAgja/uDI6MJSii+hx7e5qPF3S7ctf2pLOctOb/eXpNx24NL1Ck5R+EShESuOmN9dbRn9q20gjzEdlIqUuw3Y+bgDGv4lIDe6HJbr5eVw6/6t5YL7lsau5YMbUNpX38HvfhI1/0owfhsd36XgcVZMHAYKIyjqOHU9QUwI9zm5G3WI9rqwz0uC3w4FB5E5EClnoKa5Che54+gLlmwn9hwr6HQPyriKsMngGgLvLhUGkb2bEysEcjx3V8G86r05mx4Q4LFK21VoUoXuZ911nlvkFTddXvIhhs9LaErBgSZ1Ppg0Ory7Yw2d01ieANzLX7WHKOdMYktnQMK2ha/X3g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876ceb4c-a194-4bd9-2ce1-08dc3ec0d802
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 16:08:36.1694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfyiPjccif/oJXiFuPfMyFIVsOwAbqglnD629yI1VLn0zp2BgE3lB3y56odFZRHymOadT0EFvHa5chDw+j8xtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070110
X-Proofpoint-ORIG-GUID: caXRWV15waaecoVnHdy9UiLlGB5oVk88
X-Proofpoint-GUID: caXRWV15waaecoVnHdy9UiLlGB5oVk88



On 3/7/24 20:46, Zorro Lang wrote:
> On Thu, Mar 07, 2024 at 06:20:23PM +0530, Anand Jain wrote:
>> The current _notrun call states that the scratch device is too small but
>> does not specify the required size. Simply update the _notrun messages.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
> 
> OK, I think that makes sense to me.
> 
>>   common/rc | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 50dde313b851..5680995b2366 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -1834,7 +1834,8 @@ _require_scratch_size()
>>   
>>   	_require_scratch
>>   	local devsize=`_get_device_size $SCRATCH_DEV`
>> -	[ $devsize -lt $1 ] && _notrun "scratch dev too small"
>> +	[ $devsize -lt $1 ] && \
>> +_notrun "scratch device $SCRATCH_DEV should be minimum $1, currently $devsize"
> 
> 
>>   }
>>   
>>   # require a scratch dev of a minimum size (in kb) and should not be checked
>> @@ -1845,7 +1846,8 @@ _require_scratch_size_nocheck()
>>   
>>   	_require_scratch_nocheck
>>   	local devsize=`_get_device_size $SCRATCH_DEV`
>> -	[ $devsize -lt $1 ] && _notrun "scratch dev too small"
>> +	[ $devsize -lt $1 ] && \
>> +_notrun "require scratch device $SCRATCH_DEV atleast $1, currently $devsize"
> 
> "at least"
> 
> Why don't output same message with above ?


If the error messages are unique, it is easier to search for the line in
the source code when it is required.

> And why not have indentation at here?

Is it ok to overshoot 80 char? we move the line left as much required
so that line is possible fit within  80char.
I'm ok to follow any better ways if any.


> 
> I think the message is long enough, so the $SCRATCH_DEV maybe not necessary,
> how about
> 
> 	[ $devsize -lt $1 ] && \
> 		_notrun "scratch device too small, $devsize < $1"
> 

  This is reasonable, I will use it.

> (same above)
> 
> With this change:
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> As I've given review points to patch 3/3, so I suppose you can change this
> patch with the 3rd one together :)

  Yep.

Thanks, Anand

> 
> Thanks,
> Zorro
> 
> 
>>   }
>>   
>>   # Require scratch fs which supports >16T of filesystem size.
>> -- 
>> 2.39.3
>>
>>
> 

