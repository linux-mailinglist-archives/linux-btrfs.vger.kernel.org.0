Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3140858C2AD
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 07:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiHHFGx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 01:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiHHFGv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 01:06:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DAD6300
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Aug 2022 22:06:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27843hlR003594;
        Mon, 8 Aug 2022 05:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=lG0H/XONMifPa/r4mgLjbYxJ7kLEllxmHXDb+IERY5c=;
 b=ni1efdjBZ9i6CL94x+PIZOM0aRKTYuNWG0tZVZzlqXR7cJxG6cvtO7CjDlTMu/X7jcdj
 12VYxqBhk4FxwBafVb2O7kUgkiQNr4xH5n/foCN5BkveN/oj8wphLoZPRD+h5ALL5wpL
 wBc4Dg3IqeMDXITQ0MGHVhQiyLByWKZciT0b3pu2eEJNGb5fzZKd0bIfgOxkvbM5PQTC
 Xq6pBctVDGUxvifC9cfC3KRhZFWO5T9c0OsgwoHLWavzVMyRkIHoumzsKGIZHHKmddqw
 IXZEEj8Gwopofs7CgpS/62kzjO489AhquwygEh8Tv7c2o3QEVIGxKiIwfl7w1DAg5F/7 yg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hseqcjehk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 05:06:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 277NBKuu008524;
        Mon, 8 Aug 2022 05:06:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hser1jg4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 05:06:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kge0x2DEhfb3DUynsdt5Lc3O9Dn4mEisJc5Ikv5Uw8OsoeCognI9xrAkOPPSN38o7aNycLpXfiDaAnzi/n8phaAM5bGCsYANYWTBfOQAq6sXT6cptW92RgXlwwLvoyXtHBcU62Kx2nHzix55vzylgBkZo62xgoNhdy1Hfx0xMlSGpmpfYI2qmU9acUqrUraxCJEIh7tJZz/8U6UMlD10XLM5EFIGv2Por8brxJSQDizhX9XLnW+yF63GOxq+5Fi0LcISaHvgyc01dsXsqJPXtfeoOCE1f5/T0nnrj0fsPXQXGGhU+2rfwwyfkVwXrhJdrIPLo9FG6mH4RaeRkQWojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lG0H/XONMifPa/r4mgLjbYxJ7kLEllxmHXDb+IERY5c=;
 b=X0bjEXyLfbPPDuVDy7SvaSy++11IYiBYSQz+yLP9AzLy/W0wSl30jWVaH4aXSahkZr32xNF3XMQqld+ETDeTmAau6QjetbSoEROO5zHBGCJ+UqZ8NF/db/anQyburqh96xuljrVwm8FL4rErkEAEIfA72bZQWcOOyRjljK78LaCvr9tUGeoLCooKnnYSkOriUYhtVJqCPqwZdXLDBj+x7uc2BnWwVSgs9uGOHIsliRvAaNxuukOvhS7bP8AZ1WuMVBF9lDN90B0UvjCywEUt9Tyzcf+2aqzABF9O2BEQGtcWc9uf4qiKdmycI0qaKIVGIZjeCjywaIBD5K7W8yfRvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG0H/XONMifPa/r4mgLjbYxJ7kLEllxmHXDb+IERY5c=;
 b=rlAzuqzb8jwx4/+1t+eQoI+g+vhJjUx9r71V9TCUyXasWbL6zaRW+coq+f95CTZT5r9uEAjzMFp82+KxfcR6e9nkQAL6fO2Q0E5nVdEkpv2uNK8upoDKuBxrE6k8pWPme67n7wkl6NZS0wGXkEcXcGbVPril0qvfo2Xb2J/lE8o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB5677.namprd10.prod.outlook.com (2603:10b6:303:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 05:06:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%8]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 05:06:37 +0000
Message-ID: <cf1e829d-bbe7-8948-0de4-a2d6cd774de8@oracle.com>
Date:   Mon, 8 Aug 2022 13:06:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 01/11] btrfs: don't call bioset_integrity_create for
 btrfs_bioset
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220806080330.3823644-1-hch@lst.de>
 <20220806080330.3823644-2-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220806080330.3823644-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0203.apcprd04.prod.outlook.com
 (2603:1096:4:187::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60245017-fcc2-4a47-0cef-08da78fbc559
X-MS-TrafficTypeDiagnostic: MW4PR10MB5677:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mK8x3KOaLFPuveCURf0cbiW+soQOKd+R8VDKosVFk5aNFYs+7d/MsK5qsoINxJVrXDrSgxMI0NJnIatNT81pOMFWNtWEkLVpyT2InYuNOGBdKyll7HV56oa1mjiVjQrKzsJ8E7ocGzF9RuNrjd6E/NNCFDnr8Hd/j/teDYV1bjh3OYl5/TqR6y8Qd1rrBIqG0sza0XLZBtlGcGEN2STJu7uZ995Vx75tjJRR9+RxKdfto0ta95CSDJQVFt36ii+o6+mYuJccnRplAsKAhjATUMuyV2drC4HGjK0JlexghY/UvdnWsS9SxYbDQUXHKA2slSQCGmwNaug5iiTLxpipPeZpetxmxh1yex/RJc4vw7KWviX0Qci6DC1OsMDG4r/iYerQcx8doWmytDPsX3NlYHJXerAYKLIT09nUYF4t3mXIfjYJly885PVuB6pDZPpGKHhlH+6uyI2V5cVe4Lv/ahfgUINcjubs4w7bJg2Ja3/JJ17gzZsA0bxfq0xV/b83sNt5JgHFIy84Ly4Rbb34ZL4J60FiFOvrcG9JPFxGa1uYl0C+ZAaq6o8fpBIzdHh9KLIxegVSQrkREVbKXxIjtN+/14LPuW71KKD+DvfSRiH8iRCnrs4JjfrpxI7C3GvcxlrPC9d6KEMk6En0995iOXWjYNY72AM/P3waW5jF+BBskk7dsxKD8upnG/dEQ8b2hh2DFwC8IEIaYnEuKn++6HTt6+WKft7ZluV52+PtJsWkhX0TcmRnRrAk6kP+FhjIJn7x17OwRWEJ9EqVwUIQ2RGKutT4G3bY2riT1QWPkFiXJPhcTVTMdmWqbhsCYkdTIjzA02td4tT9t6/ZVGVBUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(39860400002)(376002)(366004)(38100700002)(110136005)(31686004)(186003)(36756003)(54906003)(83380400001)(316002)(26005)(2616005)(6486002)(8676002)(8936002)(5660300002)(4326008)(478600001)(44832011)(2906002)(53546011)(66556008)(66476007)(6506007)(86362001)(31696002)(66946007)(6512007)(6666004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2s3eDdyUDZqK0hDYXVOQ0JyK2lLNTdnQ05rMnV3dk54NmlyMUNldlBJMXk4?=
 =?utf-8?B?SzBPMVgwZWU5SlJMd212YklwQUVqRjdteVZvdWpLK0RzTjJQaUJMVE9YeGQ4?=
 =?utf-8?B?KzdzM3M1OVlLWDE0SWRBaCtoVjRmU3B4NUtwSU1PdkRoamVaSG1JNFVZMzBJ?=
 =?utf-8?B?Wkw2VXUzVVFJc1BMUGdOLzNjaHpocWx1dHc3VnE1dVZnMFhkaUVSeWhYOHRu?=
 =?utf-8?B?VVNxSnR3K3d4c2hLcDhvd0laMkJVME9oRW5vdTVRUzdSUUN0L3BLVjd5QmRR?=
 =?utf-8?B?blF6SjRyOGFrcXE4UUhUYzdoWW81aG10Z2ZtMFpUK0RyVVVDUURqWGwvallv?=
 =?utf-8?B?WktUMFBaaDcvenJQOWFXcFQ1aExCNVViQU94a0Q0OURGOVZ3T0tFNEc0cEdH?=
 =?utf-8?B?Sld4T293OUV6cldUaTlidytyeC9CZlJzQXhYMFBDdmdjZUFlQ3grZTdWako0?=
 =?utf-8?B?V2hGTlBDWXZkL3dtWXRWYkwxVnk3cGI4OFQxWVNCcyt0ZEVod2R3aTBMeFJW?=
 =?utf-8?B?MWlKbkV1N1lKV2tJeE9rT2pON0dTNDVNRlhCTUdwUUNXVFdZZllWbm5QS2dG?=
 =?utf-8?B?R2J5cjFkWThNbkR2ek9LVThLUHh1RlpvY3hUeVV0VUpWc0RTUnpYVWhxcEMx?=
 =?utf-8?B?ai9yVUJPSUcyaE4yWWdodHlkYlh2dU1rUVRDV1JZMHNLYnJNZTFiSlZ6S2JI?=
 =?utf-8?B?Mk1QejFmUGJEbjBrT2twQ3JBY2xibjhWNGl0SG1tRXFLSEpVd2hBZklLS09O?=
 =?utf-8?B?bk9HeTkva1JianJ0UktnTi92TWVFd3FLcmxwVnJCM2Nqcms0TzU2bXNmUW5t?=
 =?utf-8?B?R1E3NllWUXcvcXhUa1Bwc0V2eUoybEx5TXVPbzU4NzVWckorYzhodU1iaVFO?=
 =?utf-8?B?bU5HSHNGTzM2Y0dJZ0d2WXdXK1dRZXZxOERZUmlpV2h1QkhHY3Y5QWJiY3Jh?=
 =?utf-8?B?eXZDODkwNDlQQ3g1ZlJhTHJVUXdQYU9VclBIUjFYYnFDQTFHeURjYmNvT1Fr?=
 =?utf-8?B?ZXV2SDFoY0VDRVdDYk9IbHZGeElndkhXV01oUUxvdzRUdldONFliTjVTVWt0?=
 =?utf-8?B?MTk2dFBxMTVuejZNME1sV3JDT0pYcmZacXplaWIvc21HTjlHK1dRTmtvTHV6?=
 =?utf-8?B?cXNQTGJTcXphcWJLbjJabC9DdlFnVDlrUEt6WlRLZ2dXSzE5ZDFjblkrVG5m?=
 =?utf-8?B?b29DaERtYUdFRXVMTDU0dTQySk5LbkM5N1dLN1pBVzRvdnZUS2hESlB6YU0z?=
 =?utf-8?B?ekNoU1NHcU5NN0w4eU8wbmJsQU5TaXNTTDhvYnJTd3Qxc3lTaUkvRVpSWUVs?=
 =?utf-8?B?TGlsZENHaWdqdmtYTEg0UG8zeUpFZHdxQW1TSkVJak0zeWVUQjNOMHZKYWVR?=
 =?utf-8?B?QnhlQUVVZnVjM1lwY1poNDYzSEMwRXNBVlNtdG5iU3BQdXJWWkRkN1ZjYzNo?=
 =?utf-8?B?MzdJU2l4c0ZZaDYvQ2VEYVpNWXVRdHdpaTY5TjZGNGdZamNFaTlzaGQzZ2Qv?=
 =?utf-8?B?cGpmWVgxU08vYTRMTUd4TUxVMWVGVVg3SXAxZElvcjJVZFJ1U3JUYStRMjU2?=
 =?utf-8?B?OWN1WHFCazVkdlFCWVQyNnRoaGlXcmY0OGx4UlN2WnNWdnlNSTJxZFZTZ2lz?=
 =?utf-8?B?dThDTWFnT0F0ZUJackxnNDEvSjhZcGxodDFFM0tmVnhDTm5VbFJKZUtuQlhL?=
 =?utf-8?B?amczNjMwcmN2N3hEbUxnUWhjK0dGNDlkVnJlZG1ObGIzR2tSaEtIbXYzME1s?=
 =?utf-8?B?dlhNR2U2R0FjQ2wrK1g4VEdwZnF4RFlwNkRiTldQYWR5QjlUVDRtSkQzQmdx?=
 =?utf-8?B?WE9LOTVQdmQ5d3JJTEhGS2d2Um03ZDZlSVNIYmowSXVpalJjYTY5YVd0TDRj?=
 =?utf-8?B?SlpFY2U5M0J3TG9RQUNYZG1sSDJXSmQ5RjluaDcrYXlrVTBWRis3QVhPc0U3?=
 =?utf-8?B?Uno3UG1UY2lPLzdiWStTYW9UclFrNHMrdVo4c1JCTk9aWnhBbGVHWUxwVGo2?=
 =?utf-8?B?L1FhTkJtS0JBMzNueVlUZUxqemJVYlQ4YktHZ1RPcG5jdVFuNm0yeUJTdUNq?=
 =?utf-8?B?TlJOa00wTmkxSW5UWWQ5b1JBeG5zc3gvREdSbC8vMHhYay9NSDFsQmMzdlFH?=
 =?utf-8?Q?Da/oFN0JQrZS36/UnaxS23Zt2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60245017-fcc2-4a47-0cef-08da78fbc559
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 05:06:37.2074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmBGunM6ixsJxHx31MQ6LNOnfDSk57FHVGS1Ib7fi6YHRaJPELbax2TDCam1VzoTTbpnJrBctfXcit54y4PtmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5677
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_03,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080025
X-Proofpoint-ORIG-GUID: kCOu_yLKhx6x4H1iZvupkqEG4IPvo1Ox
X-Proofpoint-GUID: kCOu_yLKhx6x4H1iZvupkqEG4IPvo1Ox
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/08/2022 16:03, Christoph Hellwig wrote:
> btrfs never uses bio integrity data itself, so don't allocate
> the integrity pools for btrfs_bioset.
> 

  (I couldn't catch up with v1 / v2, sorry for the late comments).

  Two questions:

  This patch is a revert of the commit b208c2f7ceaf ("btrfs: Fix crash 
due to not allocating integrity data for a set"). So nowadays, integrity 
data pool allocation is not mandatory?

  Why not complete the support of bio integrity metadata instead?

Thanks, Anand

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Tested-by: Nikolay Borisov <nborisov@suse.com>
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/extent_io.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6e8e936a8a1ef..ca8b79d991f5e 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -255,14 +255,8 @@ int __init extent_io_init(void)
>   			BIOSET_NEED_BVECS))
>   		goto free_buffer_cache;
>   
> -	if (bioset_integrity_create(&btrfs_bioset, BIO_POOL_SIZE))
> -		goto free_bioset;
> -
>   	return 0;
>   
> -free_bioset:
> -	bioset_exit(&btrfs_bioset);
> -
>   free_buffer_cache:
>   	kmem_cache_destroy(extent_buffer_cache);
>   	extent_buffer_cache = NULL;

