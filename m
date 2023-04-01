Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F7B6D2E5C
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Apr 2023 07:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjDAFUg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Apr 2023 01:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjDAFUf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Apr 2023 01:20:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0201B7C6
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Mar 2023 22:20:32 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3313q3Hb001306;
        Sat, 1 Apr 2023 05:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=IzdqzW7d/eSHXEmCglkkjgaTEGWGZ210p0VS6vBX8Ng=;
 b=JsdBvdREPcS01npS///IWyofvM/CVpJsTAsxPf+n/GJX6piuMvGuWBieqeCrDx2c7QLs
 pYz/mK6XgcZ9MYgfwE1rbNCjvvC2/G4QxwSq7ocLFmq0MTDh6DFvJwx2OeGrS2xQIk5/
 L3QKTcbZ5PfbJOnBpVEA20vfr+HbK3oBdghFVRJlP+rLfSlp6+smnIF4qeHJ7ejD2p6e
 jJw+ZvG5VJOY0bnGXRg9iH9nptauv7GgWC+4pQDISXQrR8kjAgWOv4SD55bLb3zTi6NI
 BgoKbFQnojmbXgljZVtlc2nFboWyr76+rtTReefPfvFKJhHPpqkDE5pYJUu0pfEZlOXz 7Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcncr1v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Apr 2023 05:19:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3311XoHg015113;
        Sat, 1 Apr 2023 05:19:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ppb2b4wna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Apr 2023 05:19:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQrUlV8SZh3xGSrupHSFLFsgWnxGMoakdg1kcW+1XpWfzt5IPfidHsDbe0i+wDjrv072ZgiDnSCKowaB+87TSXd3ewXXpqbBYs58rzTfyxxrmAliL7N6QrMuoq41nR3b8aJ3l1biUCy0yoiRJ5fj+K8IK2E5K7NZK5I9s8FU5addUf8RjfNk7nnQKcS7NEz7aPR24a3bAl82Mu32ii4Tmo33rSJORDoRQiPRibtKccgsqvTfcNs5DkKKY7EiLeyH3rRWSocBv8W3hf7pV898iXrbBojg1Tk7hoUoM5+/93AqP0IchXRryorAtHR1w7FRRZQdczhsIgKCnC+zEi7MMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzdqzW7d/eSHXEmCglkkjgaTEGWGZ210p0VS6vBX8Ng=;
 b=PNmOvvITN1yE999vcobWK8Qxcl2sQrz6+TWq6dDmuMWsNVNKQJ231WAfO85xjZ2jccTmas+v30+FY4IXilbrgTjkof5cd+MyYmwgvWhZC59RU9D8cx29IGkH47TtKvOrLRJU0G6pIEfPLJpodA7Iz0DPZJKO9SQo+PPjaqZQGIOzKTjgj+XRNkAYTv+vxVlV2S0WyLfHeT58frx3f2dGIi+pHedGwlpdN6p4GZaZVSiyz5BfYNn1cgbOEYG5RrEb4600yMHBGNgL+7GpaXQPoOgVInndx0b3QZvJaP4Icb4WgSKf4GG6Rcwwu7uhUPaHVoXsOkyzBx/kN80RaO+vaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzdqzW7d/eSHXEmCglkkjgaTEGWGZ210p0VS6vBX8Ng=;
 b=Di3kJTyBKjhyYfSgeQqnkBhNgb3lRJ0C3CxYiyAmnkWdELbNcywqyCsMFbtDkky4Rf339LjXbM8LRZPvf9Jr7BzWwG6Y/KXujIx3dtbdToAfy8bw/Y+n0mplddNqCz6buHWvYYOBnBkQJ+vjdd6LXCJ+Hx76izTiq/gfHU9lMLc=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by IA0PR10MB7273.namprd10.prod.outlook.com (2603:10b6:208:40b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Sat, 1 Apr
 2023 05:19:49 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::4982:18e8:90eb:9bb7]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::4982:18e8:90eb:9bb7%5]) with mapi id 15.20.6222.035; Sat, 1 Apr 2023
 05:19:49 +0000
Message-ID: <5473f8a1-e720-cba1-579c-fdef7787f9dd@oracle.com>
Date:   Sat, 1 Apr 2023 13:19:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/1] btrfs-progs: mkfs: Enforce 4k sectorsize by default
To:     Linux BTRFS Development <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.cz>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Davide Cavalca <davide@cavalca.name>,
        Jens Axboe <axboe@fb.com>, Asahi Lina <lina@asahilina.net>,
        Asahi Linux <asahi@lists.linux.dev>,
        Josef Bacik <josef@toxicpanda.com>, Neal Gompa <neal@gompa.dev>
References: <20230322221714.2702819-1-neal@gompa.dev>
 <20230322221714.2702819-2-neal@gompa.dev>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230322221714.2702819-2-neal@gompa.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|IA0PR10MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: e813a131-13ef-4cf6-6b26-08db3270b6a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y8ALrj24/bPVWDeeV7EYr3YuT6X3DowMfUrrB3GVUSnX5ogM52B2fXybzWldn66U7Kk34Yr/nROv1Wqc13xDw4m/lvTlKfhZ4CzGSqhdiXnC7bcR/y5SYq+omP1AXkmSFCEDIEQgBFT6wdjBVSQ0tlfI6M3vSU3Ku8zzMKvKVru60pUqfZi2cLqa/XQxkVbK8cKoFUszusJ03xaBDab+Avny6hBCqIDQ3QCgMg7Nh1A0W6GHpC66bH1EZe0BdYFl+Knmg0crr6/QIzvLnwDZXFEU1OVW3bITIwcoAucrnt2eA9jzy1UzBo1b2BMlfyvjALcQ5lDMmhe8iPzBwRJTWChFajFFIM/2XaKS95YgB9+p8RPD6i4FOOnAR/Rh+k7LFCGC5G7FAbyhnQIvHqjbcX3rk5w9PMz7uEOpeCOclF/4ZxoWoo3OKl3CPs0T5Uipnl/cW5MAnWpSojVSzExonlaszxLCK6ob/1YvQMWxd9zGlBiwDFxcXeFDMPlQMOLNxd6BI227QO+L4D3MqfebxAKuSRHC3hSvwWiKfZowzJTofnzifu1UrBwp/Buce368uKYHOf+NFOmTgbnYCOpKzwvj9NJw7/GuQm3Y8521uYx4Ybk4OgISfj6xuBTBR9jplBiPgAW89ux1xvlf/gQS/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199021)(44832011)(2906002)(8936002)(38100700002)(7416002)(41300700001)(5660300002)(40140700001)(36756003)(86362001)(83380400001)(6486002)(54906003)(316002)(110136005)(53546011)(66476007)(478600001)(6506007)(66946007)(26005)(2616005)(6666004)(66556008)(8676002)(31696002)(4326008)(6512007)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUtybGtBck5aWnBTVnRxcS90YW4yU01JL3dNQU8vSlgrZ3ROUk9ZdGd3a3dl?=
 =?utf-8?B?WHNjUmZoRkVvZUpkck9weEJmTUJYOTVSR3JJSlYrSW5IcEd3Q2VyODdaTFJO?=
 =?utf-8?B?ay9aMHZyRnhYc3pqekRKTklQZk96cHVDSnlRZS9aaWlpOG1hSXg1ajNrRDcv?=
 =?utf-8?B?cWVXNi9ZNVAweC9RTWdrR055dUszZ0RJby9hRjdEWVJNU0VXcDZJYy8rM2tL?=
 =?utf-8?B?VGppclNvYUlRY2xLaFhnVGRzbGRHbXg1WTA4eFd5RHZ4WUJMdWl0MDJXUThO?=
 =?utf-8?B?ZlpheDdoWmRxcndTRWx2RTNpQkN4TTk4SGZXZHRZeE81Uk9WQ29GSHd0VHNU?=
 =?utf-8?B?cWFKVENjNWNJcW03L1Q3cWhjZ21BRUE1cVFvNXBJRXZ4QzArT0VTWldmNy91?=
 =?utf-8?B?cTk5bDR6UXlpZ0hXTE1LeDlOdXdXL04wcnJodmFPK1ZXS2o3NDVFVGlxb05T?=
 =?utf-8?B?TWQ5eVRUUEtjK2Z3c2tmVklWV0lwVElZYkEzUU4wa2duOUErWUJpZ0s3SkZT?=
 =?utf-8?B?eXJOT0VXYk90T1hQTkhSckZLck9vbXA3UDFDUURjSXN4dG1CTnNwSFlQemZS?=
 =?utf-8?B?L2ZTeTFhcWpOY0dJb3dmdEhyeTg2TWxNVHp2MWsrY2gzbTJxNGdYaWRHU0RQ?=
 =?utf-8?B?NWx6emtVSFdlZ3FIdUNscm05c3RjbnJOWE83Wm1HWXdyVUl0aUphNG1xSWQ1?=
 =?utf-8?B?Q1hxalBzSzlJaGZJQWFkbDdrTHNFL3djZkM3bmtDaHhldWFxY2V1NXIwMlYy?=
 =?utf-8?B?SnNDQnU3WVl3blM1RzRhY0ZBMWxQZnBHbDdJSXM5SExlUDVRdW90dWY3RE80?=
 =?utf-8?B?a1djdVpnQjN5d0ZlVzNxS1ZibTQwL3Q1YTgzaUVmV3BCT1ZxeXdhK2toTVM0?=
 =?utf-8?B?Q3ZlL1dQVDJKczM0L05xQmZsUERhbVdkWkV1UEFGMDR2S3hyU3IwdUtaMHVX?=
 =?utf-8?B?cGNVSGRxWXJPdWVONmpJcFNpdWkvWnJ6bk9STlYvVGtVTVk5NTB3QmNib0Y2?=
 =?utf-8?B?V05HRlBkSUx5MzF3VWczZkNONUYrYUEzMlo4VWdrV1dkekhNVE5kY0V1QUI5?=
 =?utf-8?B?bzFlTVNTTDcwb21Qd2lJT1RVS1ZmeTN2aVZhSThhYzRDTTBnOWI2MEJhVjRZ?=
 =?utf-8?B?c0VndTlXSW52cDh1Y0xCQ3cwN3dRTmpaK3ExQWpyWEN1RXhQVW9ReHdmMngw?=
 =?utf-8?B?eG5hME00bVhDZy96Tmd4RXF4K2RPWkowYVdNak96ZHlxa1B6QW1ZUU0yNjRz?=
 =?utf-8?B?MXUwOEFVSDk2c0tZSVp6QmNLYXYvMUptM3BiMFdZaG12WGI1MXZUNkdSQkNR?=
 =?utf-8?B?KytzNWhDZk05ZU5jRXF3R2hBczF5dDdYMmRna01DT0hFaFJteXB0MWRVckFl?=
 =?utf-8?B?RzNJTWZZQ3E3SlJoZWJ4RThMU0hoTlBLYk9tbU5PRDNVRUNyQURVWGQrSUlJ?=
 =?utf-8?B?MGtXQlpIekRTOThISisxUmdtczVuWkRESnRLeUVPRDVES3I3WjBCZ0N5eGdw?=
 =?utf-8?B?UDlNM1UyNjhCNGM0WStRcHk0N2FGQVQ5VWNWYndiN3U4R05CaTg1S0F1YTdV?=
 =?utf-8?B?ODFPWE9STkZmQ0JjeitPcFMrcWJkd2pYUDVmUzlDZlk4Z3drcFdTcEYxWUd6?=
 =?utf-8?B?TGJUb2NHLzk3eHd3NGxpREFnb1ZiWDlGSXRzNkloL09kLzF2UXQrU3Q2ZXVt?=
 =?utf-8?B?bkQyZG05ajdlS0dlcWR2T1RsRyt0S0xZMVpYUEVMd1RvRjdRNTVRZlo0dkVp?=
 =?utf-8?B?NG1TbVRSTjVVTkpod0R1SmhPaXM0aWdaUzlVN2VWTUJXNnY0U3Mxc3loeTlz?=
 =?utf-8?B?SVFhYnFjdko0eE9SOTlnV2t3YlFGd09MdGFxUEk4YS9XanlDU0FONVd5Y1pX?=
 =?utf-8?B?K1Q2UFJuQVRFYzFxb1FzbGUzSVBjQ0YySUU5eHNmdmloU0VoVThjQmZUZWll?=
 =?utf-8?B?WEdGWWZ1L3k4Y3NiM0p1bUhzVjNwKzdnTTlsS0ZVak5nczhuTHRpby92MFVv?=
 =?utf-8?B?WkRFckhJc01ORnN4ZVUwMVM0NC9GaytXQUFxSitPN1hWTG9GYWxuV25YSlRw?=
 =?utf-8?B?SHlxRkZEYU42ZW5Cc01pd0YzNkZlZmdaNXd3UWhiRWdub0RaZElsMVFVWXR3?=
 =?utf-8?Q?OjEAGZkn6AUV+zbjYW86VXBfA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SDJwcy8za3liSm5hMzBIWHhLSERJTUk3blVsT0ExZWFUczVtTjdIK3FZTHhH?=
 =?utf-8?B?TVpPbkZERUNrOVNoUWZETTE1cjg2ZmhRVnA5QTk2OVI3RE1QTmc4QUNYem95?=
 =?utf-8?B?VExlOVlpWDdMUkpKcHJIcm9GYm9pNXltSnA4aUdnQ3NHdHpSRHB2SXhFbzhG?=
 =?utf-8?B?T1V2TXRMOEIyNWI0WUp2c0NPVDJicUprMm56T2NuWTRMN1k2UGNkY282bG1t?=
 =?utf-8?B?RGJvV0phZHFISEJwRW9NK0pVOVlla3pKUm9rMXI0aXdSOStYamFvektTWUxJ?=
 =?utf-8?B?eGIwemlMSWU1a3lNcnRscHhwdCtRR3BQOGJla3FQRFNtSnhNd1FtQVp5NHNZ?=
 =?utf-8?B?ZTBjQ0QrWWNnc1lxSUlBdks1cWUrNDAzY3g1VnJ5ZlVjc2hub3VwZFU1dy9p?=
 =?utf-8?B?YmdZWVlKazk3OXNlWGVtdHFNc1h4RGptdndyTVlDN28wZzMrNGViNERGTSt2?=
 =?utf-8?B?N052cXdmSzZWUE1CWFNVSHkrZmRQTG5FZjJib00zNFVZYmJXMzhNbUtUdEZF?=
 =?utf-8?B?SzVrQzFjYU5BR0YyRXFHck1RZ2JGSktUMWlsN2NjWURMMWFkK0liT1k2RWtq?=
 =?utf-8?B?NVBVODM4VnJoUTdtSG9JaklUclVvN0xqa29sRFdZWGZ0MDd2S3o3SnNtMndO?=
 =?utf-8?B?N3JvMUNjNWh3eWxqeXRMSE8zMS9TMHNrdVVaVWxjRHNwc2pLYjNkZTVxQ1ZK?=
 =?utf-8?B?azlBaVFrVGZxVlJWeUx6VG1zK0hMZGROZEYwcVlGTVdkOGhXenI3d1pRY1Y3?=
 =?utf-8?B?MkI3TXQwbXp6eURSRXFxL29IRXVxZHIzRUcxcU5WQytSSWE0R2NScmlycUk4?=
 =?utf-8?B?TDhLeXZ6eUl6YTVQeFV3VDRkM09WUWhuY21jSE0xUXZWZXhXYmwwSzM2ZVVj?=
 =?utf-8?B?Si83NEdPdmROSUlscGdBVnQ5c0dpVG5uRmxId0RWQ05KQnJWVzVhdG00NTB3?=
 =?utf-8?B?eU9UeGk3dm5PQVJ3YkljYkZ1Rkc0cEYwN3ZReW5WdE5EOVJub2dGSEVLQitY?=
 =?utf-8?B?YzdnRTRwN2l4RlBvSWtCR2NtVGxkYWF4MllYMkNjSllNZGlLK2UyTDNtaE9h?=
 =?utf-8?B?aTkvb2ZkQ3JMd2pHaExveENsV21KdFhEcGllbkJ0UG00T09yT0FJZ2lhZWtE?=
 =?utf-8?B?UmlLVFJhMkozZ3BKdHI5UmJwcHFhVG5vcWlqOXF1N1MwQ1JjcVBKbEpGN0JP?=
 =?utf-8?B?V0R5RmpmS0hmb3dDUmttT2NZOS91L0JNb1hXRmJEaldsc2F4cmp4REdQblNv?=
 =?utf-8?B?TmlGQy9YdG1scUU0eTZjcEw3M00yYXFOVFVVUmpyUmlCMXcyOWpSYVpUV21J?=
 =?utf-8?B?ZE5tU0I3eXJNUmFwSmVaUHAxQkdCUEZXRTY0SXArUUhOdWllTHNCSTFpTzdV?=
 =?utf-8?B?UnpBUktTYStERGRicVgyQUJnMlIrK3hpTE16d3RXMTljbCtNUzRZYnh5OXNn?=
 =?utf-8?B?Z1E1bWcrajdkMlZhZXJSbStiSHo0VitzNG9raS9BPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e813a131-13ef-4cf6-6b26-08db3270b6a7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2023 05:19:49.1245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EADn/Fe8w2qN72k20K1Y/5LghtlienZPLWjsGE3sAF5k7UoApCFLoUq+sk6hktbJiexya3SNOCtF7yNBZ4QqRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304010046
X-Proofpoint-GUID: 99Z9XaAahY_JBIRVKpCzijytVFnJhNqd
X-Proofpoint-ORIG-GUID: 99Z9XaAahY_JBIRVKpCzijytVFnJhNqd
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Comparing btrfs sectorsize=64K with sectorsize=4K on an aarch64
virtual host with PAGESIZE=64k shows that switching to sectorsize=4K
by default for buffered IO has a low impact, while the direct IO
performance is improved by roughly 21% to 152% for various fio
block sizes as shown below.


aarch64 PAGESIZE=64K
====================

Buffered IO:
============

FIO bs  sectorsize=64k	sectorsize=4k   diff
K	MB/s		MB/s		PC
4	 752		 755
8	 783		 832		+6
64	1066		1173		+10
128	1120		1098		+2
256	1112		1079		-3


Dierct IO:
============

FIO bs  sectorsize=64k	sectorsize=4k	diff
K	MB/s		MB/s 		PC
4	 54		 106		+96
8	107		 270		+152
64	737	 	 894		+21
128	862		1130		+31
256	846		1103		+30



FIO config file:

[global]
directory=/mnt/scratch
allrandrepeat=1
readwrite=readwrite
ioengine=io_uring
iodepth=256
end_fsync=1
fallocate=none
group_reporting
gtod_reduce=1
numjobs=8
size=10G
stonewall

[fio-direct-4k]
direct=1 <-- changed as appropriate
bs=4k    <---changed as appropriate



On 23/03/2023 06:17, Neal Gompa wrote:
> We have had working subpage support in Btrfs for many cycles now.
> Generally, we do not want people creating filesystems by default
> with non-4k sectorsizes since it creates portability problems.
> 
> Signed-off-by: Neal Gompa <neal@gompa.dev>
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 
> ---
>   Documentation/Subpage.rst    | 15 ++++++++-------
>   Documentation/mkfs.btrfs.rst | 13 +++++++++----
>   mkfs/main.c                  |  2 +-
>   3 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/Subpage.rst b/Documentation/Subpage.rst
> index 21a495d5..39ef7d6d 100644
> --- a/Documentation/Subpage.rst
> +++ b/Documentation/Subpage.rst
> @@ -9,17 +9,18 @@ to the exactly same size of the block and page. On x86_64 this is typically
>   pages, like 64KiB on 64bit ARM or PowerPC. This means filesystems created
>   with 64KiB sector size cannot be mounted on a system with 4KiB page size.
>   
> -While with subpage support, systems with 64KiB page size can create (still needs
> -"-s 4k" option for mkfs.btrfs) and mount filesystems with 4KiB sectorsize,
> -allowing us to push 4KiB sectorsize as default sectorsize for all platforms in the
> -near future.
> +Since v6.3, filesystems are created with a 4KiB sectorsize by default,
> +though it remains possible to create filesystems with other page sizes
> +(such as 64KiB with the "-s 64k" option for mkfs.btrfs). This ensures that
> +new filesystems are compatible across other architecture variants using
> +larger page sizes.
>   
>   Requirements, limitations
>   -------------------------
>   
> -The initial subpage support has been added in v5.15, although it's still
> -considered as experimental at the time of writing (v5.18), most features are
> -already working without problems.
> +The initial subpage support has been added in v5.15. Most features are
> +already working without problems. Subpage support is used by default
> +for systems with a non-4KiB page size since v6.3.
>   
>   End users can mount filesystems with 4KiB sectorsize and do their usual
>   workload, while should not notice any obvious change, as long as the initial
> diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
> index ba7227b3..16abf0ca 100644
> --- a/Documentation/mkfs.btrfs.rst
> +++ b/Documentation/mkfs.btrfs.rst
> @@ -116,10 +116,15 @@ OPTIONS
>   -s|--sectorsize <size>
>           Specify the sectorsize, the minimum data block allocation unit.
>   
> -        The default value is the page size and is autodetected. If the sectorsize
> -        differs from the page size, the created filesystem may not be mountable by the
> -        running kernel. Therefore it is not recommended to use this option unless you
> -        are going to mount it on a system with the appropriate page size.
> +        By default, the value is 4KiB, but it can be manually set to match the
> +        system page size. However, if the sector size is different from the page
> +        size, the resulting filesystem may not be mountable by the current
> +        kernel, apart from the default 4KiB. Hence, using this option is not
> +        advised unless you intend to mount it on a system with the suitable
> +        page size.
> +
> +        .. note::
> +                Versions prior to 6.3 set the sectorsize matching to the page size.
>   
>   -L|--label <string>
>           Specify a label for the filesystem. The *string* should be less than 256
> diff --git a/mkfs/main.c b/mkfs/main.c
> index f5e34cbd..5e1834d7 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1207,7 +1207,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	}
>   
>   	if (!sectorsize)
> -		sectorsize = (u32)sysconf(_SC_PAGESIZE);
> +		sectorsize = (u32)SZ_4K;
>   	if (btrfs_check_sectorsize(sectorsize))
>   		goto error;
>   

