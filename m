Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03F9599146
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Aug 2022 01:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242989AbiHRXiZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 19:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345927AbiHRXiV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 19:38:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B161CFD6
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Aug 2022 16:38:20 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IN9hIO012181;
        Thu, 18 Aug 2022 23:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rUH9YRLjrWCxNCzfIE2lj0Iiu0i7YkaR6aApQuAKusA=;
 b=x4P8WdOGZinGD/aXFJ50q8EpC/8tfdkM8uRAfoa+mMcuCRUVTbIs1sxRT9x0Ejr1Xsza
 kBxqf1/hXrOe32fgKbMBCTSh1nbA+x/zJYH7963frIk60IapgFXg4/0MJNe2Eb37+lvC
 EjncihQIdvru7tgyLsBUCezAH5s4uh4wlE3MuAYfCwPs48MopV0tQMweEnRFkOE5yRaH
 g2VuScwHV7sLOrJoi2RWgL1RWLsS+VtPuatkN+euVXl8r1Nr9pC9jNBpQRCwk43IIriv
 VGbtodW6eFIr8OUHAj/NiM94lHU//METTcdlLY3WkCbqBWg0pprAAT3IO7nhWXRvxmsv dg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j1xur80uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 23:38:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ILgGUT034201;
        Thu, 18 Aug 2022 23:38:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d4yu8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 23:38:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVnByr9lXkI3IDPq6Iz9vOX60r0xbR2Z+TL3YFOynUzRRCNEbYwsB+q4GExT/tSOto8LTI6EiWdc+tp8in73S2kt3e+36hgDyF66wjuu3nssTHGMHqDHLP+DJJn33T80t75oDR6e7CzaiTm0+9svcS1kPbVwtOwHORLBegGpcyfu/mzmNZK/Zsxq38MXpJCq3ZssUcktgjGEzfghUn99pRvN5mAcEzVE9kVL11BnkPKekgzE6t+FE9TZmENwEd4uy63zn5vbBvvh4f3gaIll79ykJyDIlKMPdC0+Y8YzjQLCWSdOHPc29ORAmy/JVM86paS92haa26kd3SySK33HKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUH9YRLjrWCxNCzfIE2lj0Iiu0i7YkaR6aApQuAKusA=;
 b=ZnuCm+woWS7GZEay9R68PD+WhREyJsY2/TVNGm21FjSYLu9sx3uKw0cQlH0KJ1BKygI2/Ax106Q6p3UZO8eEyoDsWR80cucrPIjADKrEF8ClILfzmQnyotiQ7hrGiD8mL9krPz5EZsiUXRU2RdG3q9J0HG+cgrQa7KV3Qq7gms35/STWQqp/o5L7l7RH4vl4gBw6eAQUomSvjCMeZ4TYJtUfsqi6rj3ke+2/nu9XLFGEe+HLuvGcARMrb88ChtT3ihRbSsUizDQeS2F48MZZvn4rUDMeGjQdNgILcOhfcK/J7FDl5wjxsSr/FQUqYBJb1a0d37S1z8PTzeEY/Hjfkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUH9YRLjrWCxNCzfIE2lj0Iiu0i7YkaR6aApQuAKusA=;
 b=dfsjImG1a+bMwaYEMRJ5SimMmIZiihANciDzEidnTB1ORWdJaHPDpsAJwwTbFavq5Q0Ho28+DYik7lJ2+W/4rFIRFW+Qm1kQMhibpeiXEEOMqTcM1Iw0KrgOFYktQkX2KrGnB4SkDRgdm+uaqTDvansCbFXsdQxYaY1xlYw+d1I=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN8PR10MB3476.namprd10.prod.outlook.com (2603:10b6:408:ae::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 23:38:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%9]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 23:38:07 +0000
Message-ID: <e4a159c1-e4ce-798a-762f-16d3d465f9e5@oracle.com>
Date:   Fri, 19 Aug 2022 07:37:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 05/11] btrfs: remove bioc->stripes_pending
To:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
References: <20220806080330.3823644-1-hch@lst.de>
 <20220806080330.3823644-6-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220806080330.3823644-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54a472c5-b175-4403-f738-08da8172b413
X-MS-TrafficTypeDiagnostic: BN8PR10MB3476:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0uF7LRndY4cUlbXGHk0NNwlWWU+TtqO+TZSf9125Zljtu8zfzf8WMTvXlCfe8k9AZRwMXSCKkvIZs1xUuVdSnMO5Y07hUAMw4jO7+SeluwrjBGgg0Vzun30xzda4e5CuJ67/Fp60mxp+ZfqhrHn13CLifpzAERYfZpaNzVrZRhIyiaRqOF0cOzd5r1HwaFAyyGp/HZX7zWoI9cg2n+LW10/5Cx2eHR/TmkalL+W+VAe+53iAC8dEjmZpGQxuaejLFNMwZR7PyWDxgGYZFNaS8KN6OYLyGObC1e5K/n0d3eDVDkIGYIN35+ZswaKXR6bW6h1zIH+XzFxiDExMMlU82lMDULSREqmnJl1wVmk3fFjg2tsROu1b/cPwZSzDTHKU7rSo29e+tNmMBucENFEQK/DUNrBWfTkZe9hnWWCOc4+hO8XkEreZ4zcPxh5X1LvjDlLWoajYaPLkn2ME79R0lzFRGDcNZ1iNcdcsqy4IAXz/bKOTrhgBtzbZEFpC6TDFW4byQu8gHLvgxZdqnXG5cR3nYkuyzuI8mvZXyJl2feaOFTYoFDJPfx+1C+e/yfKAimySMg8II06xkWab8jEXOFjdEYjS75rnNYmmwiXIzg0F3FIjDJitzZpOKT9bTsksr0h0VuqjOrhlum8Xoz8ha+SEUxf56x12X2qektV4nBV5HOgnfM6mWvlNoTbR36uO3URvRJj2FJ8YRN5CV59T8cY7NrGbw/IoDo+yWCFv9FJKUkq3S9CAy2ZGtAH6fmDf/VwqzB9yuqvmLTG11mnvXZoV5QrgmNDqgvvYStp9/bE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(346002)(136003)(39860400002)(66476007)(8676002)(4326008)(66946007)(5660300002)(316002)(66556008)(54906003)(38100700002)(8936002)(44832011)(2616005)(2906002)(36756003)(86362001)(41300700001)(26005)(6666004)(6506007)(31696002)(53546011)(6512007)(478600001)(6486002)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUhZcWlVNUVmNzVMKytzd1YxVFkyamRhczc3VWxPZVNNcnVtZGlHNG5yL1d6?=
 =?utf-8?B?R1U1WHp3MGhSQ0dzWndEcFdIbHNpaG9sQXJJL1dTWEhLQVA2ZCtsU2w3dTgx?=
 =?utf-8?B?L0JFNXh1bkNhcFo1dnJWdno3NDFzL0liYWJORWVtaXZDZnFNc0kranJqVW5M?=
 =?utf-8?B?UmtybVRlYTgwZlJ6RXM3cHJkTWpIdjJpc0pnanM2Q0FjMC9xRzl4eHJwbmJP?=
 =?utf-8?B?RWxaQVlRQi9zWXpHNTRXTVM5akR4OUtzNTBRMjd2V2doWExXMVM1cjdkbzVm?=
 =?utf-8?B?WkxvZXp6K3RkUkZsVVZOaVJXL0ZyblhmekNXeVN5L1JhZm5GWkxlZlpQbUJJ?=
 =?utf-8?B?bktwVW5BMXdwbVFta1hpcndkOU40M3FZdEhNOVZOcUtJUWI5MFdRbzVNVytr?=
 =?utf-8?B?RG85V3JCSTdyeGNlckh3SXhvUFZXYlh4dGRTTFFBbWJWbC9kSzExVHZDaEZU?=
 =?utf-8?B?Lzg2emVRZFNVcG05NkVDQlp4MHpwT1BlMVNTZFkvTmZmbHdBWDVmRlFNSFRo?=
 =?utf-8?B?Sk9OaUcxdGd4N1RaaGZVSWtPbEtHd2R4dDZ5cGk1T29rVEdYWXBFck0zdW0y?=
 =?utf-8?B?WmVkclJXdG1IV3VZWjZ6ZHRNMHhRY1NNcHNldy92dEcvelBNWVVjc0l5NWJk?=
 =?utf-8?B?Q2QrN0RlNEd4U2Q4d3p6a1h4TnVKSWZQUzh2M2kxdEVOSnBPc05WS29aazdZ?=
 =?utf-8?B?bW84Nk1zNkNIeVN0RmZ2Q0E1MnRYVDVCR3lRN3MzSjNHYmh4eE9SR0V6aUVY?=
 =?utf-8?B?RHY1WFYyMGJsOC8wSzhGUUJLNC9rWURnYjBGUVdySzl1SEh3SllucjBUcVZ6?=
 =?utf-8?B?Y0YvTW5YTVQxY25YZndYcEo2TFMvTnQ5SDZYNU1lYjBNZEVDK0Y2V3BtQjJq?=
 =?utf-8?B?QlhpK29UcDBBK002QjRBeDdYcFlGYkdmM1orVDcwYldGQTNFaFNlMEpxY2xB?=
 =?utf-8?B?L01JVWE0ZnVLdUt1RTlob3lQTFlSMTdWTm1TYWMrMlA0UDRPazAvYnZLcGEx?=
 =?utf-8?B?TVIra2Npdm9zcWJUTnZZcnAwK0FDcFUxSWFtVklvNFBjemJnaUhjbFhVK0sv?=
 =?utf-8?B?blFlTzNsTnJKR3RxSWxoMGliUUxyT2lNZitIOWZsVEdLQ3V1MXd5VE93WnYr?=
 =?utf-8?B?UGVtRDI4ZXBNV0lubStERHB6eGI4SUtMTG1OZk1tWmVMdFJoQU5PcTNPRng5?=
 =?utf-8?B?dlQ2NG5CcGFWY0NiWGFjQWs5UGpDVHJiSEltY2pTOEFuM3A5Qm5EUXhPLzVv?=
 =?utf-8?B?ZVhIMjd3WjlZWmd4clA3L0ZDaTdFZkVHdG1NU2tSM1BQd2Y1dzZFeExwMldO?=
 =?utf-8?B?RGFiZzNTdURqVUpXbVlIaXFoWEhCQWFLZlNEL2ppVUJaWXhPTXg3V042SUtE?=
 =?utf-8?B?MnB6NHZINVZBdG5lOVNpU1VLUy8vNkgwb0JadGRoREpSb00yaWluTmtQdFBE?=
 =?utf-8?B?cUVyU1MvL01Ed3M5M2FGL0JLK2ZaYWptdUNGd0VZOEVwWlN5eFZOQ0c5Z0FT?=
 =?utf-8?B?ZC80Y1FYLzJPYitNY0tEUFRLSWR0bWFuSWlwaUhncGx3SHlhYm5jODczS3VP?=
 =?utf-8?B?Qm5zN0lJaFlPZ2Z0aThoVnNoM05qVjExT0hSV2Q4bUdkRVVUZ00xK3p6eVBk?=
 =?utf-8?B?c05YTHJwTVVpNG9pemp0NTFYMmw3Q013WFFJYU9FaVU2cUNacUNzQ21oR0Vw?=
 =?utf-8?B?UXdLTis2ZmJEa0g0S3kxeVlMcnJOcU54Qm1JTDl5OHU1ZkZhbUFhRlB0SXJL?=
 =?utf-8?B?bW1ENTlDYmVGV1VxMEovbm14RmlaczJjMjdEeGtEOGJtNHhIZExRVkZlUGtU?=
 =?utf-8?B?VnRZVEIyb0IyOXkydUlPNmxOeVlaaTd0SkZJVzlXZGdHc3VIOW9OWkFSZ0Zl?=
 =?utf-8?B?QkR5WDJRZ0N6UkE1a1NXWkJvS0hIMzhEeDJXa3RpL1ZsN2NKd3dhQVFUaGtm?=
 =?utf-8?B?MWZHOUFNZUxnamNPYXY2aitySlBLczdVVGVtQmRjNkl2NmI5aW9NQ1Q0TSs0?=
 =?utf-8?B?YVFyOG9EcXE4eTNDOWF4WVZIL0F0QTdZZVRNQUNvWGRZWDlaMTZnTDN3SXFX?=
 =?utf-8?B?d0MrbzNqcy9mT1F2c3l5QXVyRmM2cXlBSkRtc1h2TDBZUFdvZkZnK2ZxSGxU?=
 =?utf-8?Q?swJirjhXR/VOLiGA5QGuUMU0F?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RmVHbm9RVTlPMXpUV0pKdTE1azRCY1htSUhQWkk1N0lZbGh6RlVlNUZ4R0NV?=
 =?utf-8?B?U1h5U1RYNFI1K3NiK0N1Z1pPM2tockVUZGVITzNXMUlMb3BSWlNDSHphUDdQ?=
 =?utf-8?B?eEVNQy9RR0xPZ01WUGlSZFo0eHRJVzZwQ0UrNUdSSWhNVEpHMDljRjZYSzMw?=
 =?utf-8?B?bW1CUmZYWGZ1Z3J3WWVHc2dhdWNOZWU4WjhmZjd0N2JxaGlpbW9CUFBLN2Q0?=
 =?utf-8?B?ZE8xc1U3azMrYjJQajZZUUpwOGgyRnc4ZEhrTnJwK2YxMGxaSE1WR05rbmVw?=
 =?utf-8?B?c3VDQlRKNVluTnRoT0lUM3V3c21KL1F4SzI3VVJoMCtPa3hQSGxJWlRvd1FM?=
 =?utf-8?B?Y2locGNrckRkQmkvdjFWdFBJeGNCQ1hTYTRjcG9MNTI5L1RtZmVjeERlZXg1?=
 =?utf-8?B?TFFNSkQ1dnNZUUoxaHUreUlMbi9jOGVUeE13YWdRajd2VDRheEJVa3pIOHBQ?=
 =?utf-8?B?YldvNzdONWg1SHZneXhGaEJPOXNxQ05CM3BkVHJ0ekpXbkRJTDE4aGl0NlVD?=
 =?utf-8?B?ekhGMElpNm9UR2ducm9OTmhuVytZVzBLTVJ0dThxMWtqakdRTFJOVXBOeXFv?=
 =?utf-8?B?dStSd1U1OU9hZEdDQjJVMDJnNkdKbjByYjBsQVlmZVlDRy9JZG8zR0VWQkJQ?=
 =?utf-8?B?alZ3MnFJdVpQdFZmZGVvVW1aU2c3WlQ1QTliY3BCOGNIMmxCcmJadGZxb2Fk?=
 =?utf-8?B?d2dMYngwbXBUZDFXNnBvZXNFSk9sbC9QRHBmS3BHOUkxa3dkUkRxbGttZlp2?=
 =?utf-8?B?ZFc0Nlo4RFBuSjZrK1ZXc3Q4ZGN6Ty9nVm9reG5OcVdRa0N5a0pEV0taemw5?=
 =?utf-8?B?bkxIL1RuTE9DcmtWZGUyTXU0ZzFmTUZFNGJNVURJbTdOaURUWHBKUzhLSmNx?=
 =?utf-8?B?MGlETksyUGhkQ1c2NnQxU3JxblpWdW51Z0ltbStvYWtXenBDL1BibmZ6V1Jl?=
 =?utf-8?B?WmVyWXU1SSsrcHh4WW1lWUFnSTliNlZMQUg2Rllzbk9ldlA2ZzNjSkl1R0V4?=
 =?utf-8?B?Tm5pakxNb1hJMkhack5rNHphekpDVklMRmFwWFo2dGFha1RFRTdzT0VYbXpX?=
 =?utf-8?B?MjgxZWZ3ZkFOaFg3ZURSVk5nMTQ4OVhvclVEenJTNnpXdlczYkQxMmJpSlBJ?=
 =?utf-8?B?NmwzVit5Y3Rra2NuU2Q5RFVoNGtiNHhDUFRZd1BwbDJybVczTTB1ZmhXM2Q3?=
 =?utf-8?B?cHJ6amNmaFJZbGpJeEN5OHUvNFE0Q1Q2SUExN2dPTUtvaEZ3Q2RoV1lFamRT?=
 =?utf-8?B?TzJ1VHZRRTh0YklnM3BlNTl2Z0NmUXBoSldja0lreUp2c2RXc3JFNXN0TW9Z?=
 =?utf-8?Q?s7kUaIwJKd7Un8vZhFRVpdggWn/rX93E5m?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a472c5-b175-4403-f738-08da8172b413
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 23:38:07.6776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cpd3NI96S7ws1D2otvDwhwQtp1chc7G62juK2i5WrjuhYMz3idbE8gVlGbccydUnWC3QHFsw74I5Z6aYEbBV7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3476
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_17,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208180086
X-Proofpoint-ORIG-GUID: rBdzw2YkO5sVB88nkdWiveBlVChCY427
X-Proofpoint-GUID: rBdzw2YkO5sVB88nkdWiveBlVChCY427
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/6/22 16:03, Christoph Hellwig wrote:
> The stripes_pending in the btrfs_io_context counts number of inflight
> low-level bios for an upper btrfs_bio.  For reads this is generally
> one as reads are never cloned, while for writes we can trivially use
> the bio remaining mechanisms that is used for chained bios.
> 
> To be able to make use of that mechanism, split out a separate trivial
> end_io handler for the cloned bios that does a minimal amount of error
> tracking and which then calls bio_endio on the original bio to transfer
> control to that, with the remaining counter making sure it is completed
> last.  This then allows to merge btrfs_end_bioc into the original bio
> bi_end_io handler.  To make this all work all error handling needs to
> happen through the bi_end_io handler, which requires a small amount
> of reshuffling in submit_stripe_bio so that the bio is cloned already
> by the time the suitability of the device is checked.
> 
> This reduces the size of the btrfs_io_context and prepares splitting
> the btrfs_bio at the stripe boundary.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

