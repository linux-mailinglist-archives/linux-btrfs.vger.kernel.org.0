Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B668F34061A
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 13:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhCRMvY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Mar 2021 08:51:24 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39414 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhCRMvM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Mar 2021 08:51:12 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12IChuqt190801;
        Thu, 18 Mar 2021 12:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=u00oBLu22DQLg89yhcQ3fj1JWf/OEq3CqzFS+fB18HU=;
 b=uLt/oobDQNXf/zDQ0x/2+FO6XnsupuU4pUZOGgtIIxX6fE9a0NKKbIDVs9478H37JWCB
 0c9B0p5DlDh8yw+AihlBQBJby1CpFhPnnANjna7gdw+O33yeY19SwDzgVUyLuGUVsjNX
 5tjYS59XnzCRqoPPejAyUCqUSWEJf+WtURBwUWoQ8mgUqOp4xm2M4KnseoaGZh2q6t6h
 VQGujdjWv8M9Z5RkHRq1ltixzU5OTihoBm2geKLbyOr3/mW4sqXbVwo2bRsnH6iA1m/q
 TotoqbHjov/ze5imxojP1OMuGzQcPhNRyM35mFGkJ9W0w46iIDeIiJhXKK1b5f7gMa6Y cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 378jwbqer3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 12:50:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ICk6df151645;
        Thu, 18 Mar 2021 12:50:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3030.oracle.com with ESMTP id 3797b2vxjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 12:50:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5VpIFycfjdVLRChedPKWGBws5yJoQCpu8JnKoWnJsi5GvHjVxWNMdCEK2nL7Q0sRNxb27VMgo4ui0r/gON99sBOMja4o8vdwoHkDX7nZJm7NMZubFQ8iCd6ClPu5wwxdyYpxz8eIqMtRT1Fibup3bmCEf3slDm+9OmPVWiN/0dI+qkTzuh2obkfuKmvLZcsVSB/uyfdYnD+suJutulJWUH1IGr0w5pnhuFvv7NFLyuE6mCDmlg6ZP/ib0ovXnVFS/zmG6ur444hrqxbK/pOBZojJ7edsD7QsCWPWZKh5+VFDNuxSHszKQSGwbkOzp1aQypVlCaEHelkPw1ahEbI5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u00oBLu22DQLg89yhcQ3fj1JWf/OEq3CqzFS+fB18HU=;
 b=b4rSu4LwkKJ2ndC+7rIqohzmJaylrG0W6JIUKW6nWgTLsV8FCo1aeOQikWFB7YwA8KASTQytH/+DrV9E4WWt6cLqaUyXXZQfC8FPEzhDkGySp5u/aMY0j4/eyXG8Mncqggq2nBCPSStGM/PPEBmGSzb7wC6OCmihCjToPn2q0Tv9XF9P01zzfFQwLSWguCLw+WfwjAUQo4yt58sTYOCVfffUUeDCUunThFtl70YHztPrgZIykgWWg5VsA1+DK6v8tWpZVjnA7YXO/5J7ZYXaC/btWEgmoEQWkVlvX8ahtYKhGSuAcxEQtAUDcSSWykCWrCzMHkJyVWk7H3dUiiPbkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u00oBLu22DQLg89yhcQ3fj1JWf/OEq3CqzFS+fB18HU=;
 b=I5vtHIELAVNmWTdf5wg+HcZSya+vIaZVkVfwnWhK6zPY2cDinrax1twFPX2MimSnpWVhTFab4eb6RPjrM4eidMwgI5QCJZIYlKceJfeZtAGodArrlPdD24zMRcvd9MqUtL3IUetBnzmwaVGgh7DkMUVhCfSEq4BPWoaSQ14rCxA=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10)
 by DS7PR10MB5071.namprd10.prod.outlook.com (2603:10b6:5:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 12:50:37 +0000
Received: from DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::197:4808:e2f2:a8cb]) by DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::197:4808:e2f2:a8cb%9]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 12:50:37 +0000
Subject: Re: [PATCH 0/1] btrfs-progs: libbtrfsutil: Relicense to LGPLv2.1+
To:     Neal Gompa <ngompa@fedoraproject.org>, linux-btrfs@vger.kernel.org
Cc:     Omar Sandoval <osandov@fb.com>, David Sterba <dsterba@suse.com>,
        Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        Qu Wenruo <wqu@suse.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20210317200144.1067314-1-ngompa@fedoraproject.org>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a7eee242-07d6-0fe3-04b8-57c39eb02c46@oracle.com>
Date:   Thu, 18 Mar 2021 20:50:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210317200144.1067314-1-ngompa@fedoraproject.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:e84d:1de9:17e8:ac69]
X-ClientProxiedBy: SG2PR04CA0129.apcprd04.prod.outlook.com
 (2603:1096:3:16::13) To DM6PR10MB4123.namprd10.prod.outlook.com
 (2603:10b6:5:210::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:e84d:1de9:17e8:ac69] (2406:3003:2006:2288:e84d:1de9:17e8:ac69) by SG2PR04CA0129.apcprd04.prod.outlook.com (2603:1096:3:16::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 12:50:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 921d4d3c-b0be-4325-053e-08d8ea0c6d78
X-MS-TrafficTypeDiagnostic: DS7PR10MB5071:
X-Microsoft-Antispam-PRVS: <DS7PR10MB50713C7A1CB7E847A527BD26E5699@DS7PR10MB5071.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6f/lSlyIHh60GRAs/IVyThhhn0l5l5eUEDmk5YcVSnmatUPSDRJFRZDgP76OQIc9QL0kSUBOFTFVADkCED7NIP2prDcJiYaBpOcWy+FbC5fHIXWh5u3lda4fNPabwVZ5oqr2EFbH5c5TZ4pmw/4TvRbuaA6KZnsbgvJX4JOnUZEtxZe3NfsNWKEPzuNwb5j+paTNddj+xXX5GzK+x1LdkhtHKqtzF/AUgeP60CTK7HlBEChbcOo/jV03pQBOjhyDKcwNtGzm3HgJA1K+Cz9oR4VxnPk5PT5WK9qOOpTKsFrmQEmKmWcAMw0YpFX403Mjf7GhfD1VzWqEvZXQXdz93Q5JkOhiOi1eevi+PsFau6TSyAchD/oGWRLIyTUcJOEz4kW2jIT5uG8XMQXPwbpBdch6mDtVIbKONvW5eYFxnj5NatR2GSSeLMz9rwYGJdNdi00Txfz+JZCubA15OT38nTTqieUx+2cpqc44umPucWwH/QzBtNX88YYtyHofNwCIlE7m/TCOOU7zrGSadh2SD5tjP0g80l839P8Z0am+fOchrvl/h/a9cTmSfjlAgO/4L4Hk57GRqaPC3UZpnQE0CV6hiAG8Rkzz3ZKeD9gdadDYKIR8bIgywdpRm4NjsUkd3W9vY32HiL7tU2PJX8A4NDIxxLWbRdyIBSnt7/fPyqp7VoXc8Tz+lsfvl4jfvIqC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4123.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(39860400002)(396003)(6486002)(86362001)(2616005)(8676002)(38100700001)(66946007)(478600001)(36756003)(2906002)(66556008)(66476007)(16526019)(54906003)(5660300002)(6666004)(8936002)(31686004)(44832011)(186003)(83380400001)(31696002)(4326008)(316002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aFEzc2dVL2ZyN0tNSXdUL0Q5bndnZDlzOWFkem8rclhXN3JUZ3k1Y2pDN1dF?=
 =?utf-8?B?UVNnNm5UeU11blFyTlZOVnowcU5CRDd1SjM0N2djUk9TOXFLR0o2UDExcGlx?=
 =?utf-8?B?bXk3OU42M1lLUE5jM2lYM2hNTnNUMDNQTkRnRmVpbzVQd0l1K0dEN2JiV3Z0?=
 =?utf-8?B?cERuL2lCNUh5WUZqWUk0a2xia0NnOE9kZXJ2SHgyalRyV3d5RWVGM0JQSHpz?=
 =?utf-8?B?RDMrQUx1aTR3ZVpNa3Zvdkt5QmZQRTVaRUxqMzhLMEtSQ05Fc2FhMWw2Tkg1?=
 =?utf-8?B?N3VYaGpkRXYzaTRhVU1Jd1lPVnNYSnVoQTZSUG9FWlMyamcxK1lGenNJekFE?=
 =?utf-8?B?MklBOW56SFp1QVZKWW1xSnJDSVZUWEU3dmcvSVVEM2dYSkJNbTcvK1B6Zm9X?=
 =?utf-8?B?S0hscXZFdTFWaEh5UGtab3ZoNjRSa2ZuK2hOOW13ZWI5cWxsdisvSDlxT0J1?=
 =?utf-8?B?cEo2NFc2NXBJNmdLdkxMaCs4RExTU0JFZ1NhQTIveDBGNDczMTJMWkVKa1F3?=
 =?utf-8?B?aW1xL2dzZVBNaGh5WXgzRzZSZkdvdmZWWDg0OWduU1d1Q1p0ZWVzWFVUdTRR?=
 =?utf-8?B?MWhRWlJ4MG1SMnlHbUZCQzZpTnVmekdJTFdUcGlveEhvUkRrM1VGVHZ3UEtB?=
 =?utf-8?B?Rkl4aGNrUFcyUytHOHFrWU56V1hkOVlwall3RTFSVXllUVBhQlJ0QWNtaGhE?=
 =?utf-8?B?OU0yakJtVjlPR2pnb3UxRzlpY3hjeUFFQ1pUV0dNaFVRSC8zdUVJZElWZE5k?=
 =?utf-8?B?YnVwTHNObDdKY0dLL2QyZzEwMDN2WHQ5U3o3V2VUQXBPOThzUGJuWUozdmZ4?=
 =?utf-8?B?TnVwd2pSSUdZT1JVeUpsZ1YwcEh5ODRLcklsb2dnRFNLWDVlRnBFMURTaHBE?=
 =?utf-8?B?ZkhJbGd5WnRlQ0VLRE1nU2prUW9NOSt2T29YMWRHZnM5R1lGOVpqZUx4aTh4?=
 =?utf-8?B?N3liWm9GbHlIRTgxc25vbTZ6QVVqZERYaVpRWWxPQzBJOEpKdVJCb1UzK2Zm?=
 =?utf-8?B?V3NzSjBBUEtjQXBqdVRMYk5CZCthS0s1SW1nb09XVW82dDVnOXNITUJUdmdR?=
 =?utf-8?B?TS9FdHhSZlpZU2x6MTJSb2ZVRElXS3NURThmQ2RPbzYyWldUeDA5RjlSeTJk?=
 =?utf-8?B?NXNDbDIrUFpmdXJHU0NGUTFZaUZhb3lUamNrY0JNVnMyU1E3SmhzN0dQVGlV?=
 =?utf-8?B?Q3RzNzB2WWpRNjF4TVp3NFhoZ0VXNVVEUTFISzBXTnhaWjhxZjhJelBpUVA5?=
 =?utf-8?B?VGRJa2FPRTMzNk1ySHM0VXVpL25TQy9UWWVLV0J5a3RYelRUajBrdTl2cnZq?=
 =?utf-8?B?SFpUd0Z3aEFveUVFSXpxRGdVcnhxZDN4ejZ3d0lEWUpvaXcreWE5ZVkvcEdJ?=
 =?utf-8?B?bnVQMTIzVkoyQXVJTHNxQk56Ryt2cWZzczJJSFQrZ0xyK0RGK3UwNUMwN3Ar?=
 =?utf-8?B?bW9wRFhlaFBFQUUybXpKT0xFdk5ReWZXZHFiTGMxUXJ3QWZwdGVWeXJrVGRQ?=
 =?utf-8?B?eTZFdldTSTNmd2JvQ1BlNm1Yamc3Nm04ajUxbmVobEhxandkV2xBVStqTGFW?=
 =?utf-8?B?RGxQTUc5bTJJM04rbEZEakpLdWwvK0duTDUyaHpoQitsTGIra2VCenpvMjln?=
 =?utf-8?B?ZWJYblVyS09kZHU4UGV1cjdENFNPT09BSnZ5NFBQV28vRFVGRDR6aEdHT3Jo?=
 =?utf-8?B?QmhLSHJaZjRONXV0VlVsSGxzbDFvUFhGQUpONFJqSVppZkxlbHJ0RTRLbWUv?=
 =?utf-8?B?MVhIdVZPOTNNOUFlaHhYVkdXcFFlMWVEV1FxajFBN0o5Q1p2TEhhQUUzK0Q0?=
 =?utf-8?B?L1Mrb1p4cGRaQTUxZXlYNUdwbXNSc0VodEUweW9QcWJzR3NFbVFxeUpjcGpn?=
 =?utf-8?Q?OIIrfjSkg9Xi3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921d4d3c-b0be-4325-053e-08d8ea0c6d78
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4123.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 12:50:37.1428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwVtjmrqFsVUbJt6pjPLpIDUxJJI0vfEW22LB6Qe+fzLhsVEvApoSHOu2L8v/ccyxGybx+FxVy6x56oJLizFvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5071
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180096
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180096
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18/03/2021 04:01, Neal Gompa wrote:
> This is a patch requesting all substantial copyright owners to sign off
> on changing the license of the libbtrfsutil code to LGPLv2.1+ in order
> to resolve various concerns around the mixture of code in btrfs-progs
> with libbtrfsutil.
> 
> Each significant (i.e. non-trivial) commit author has been CC'd to
> request their sign-off on this. Please reply to this to acknowledge
> whether or not this is acceptable for your code.
> 
> Neal Gompa (1):
>    btrfs-progs: libbtrfsutil: Relicense to LGPLv2.1+
> 
>   libbtrfsutil/COPYING              | 1130 ++++++++++++-----------------
>   libbtrfsutil/COPYING.LESSER       |  165 -----
>   libbtrfsutil/btrfsutil.h          |    2 +-
>   libbtrfsutil/btrfsutil_internal.h |    2 +-
>   libbtrfsutil/errors.c             |    2 +-
>   libbtrfsutil/filesystem.c         |    2 +-
>   libbtrfsutil/python/btrfsutilpy.h |    2 +-
>   libbtrfsutil/python/error.c       |    2 +-
>   libbtrfsutil/python/filesystem.c  |    2 +-
>   libbtrfsutil/python/module.c      |    2 +-
>   libbtrfsutil/python/qgroup.c      |    2 +-
>   libbtrfsutil/python/setup.py      |    4 +-
>   libbtrfsutil/python/subvolume.c   |    2 +-
>   libbtrfsutil/qgroup.c             |    2 +-
>   libbtrfsutil/stubs.c              |    2 +-
>   libbtrfsutil/stubs.h              |    2 +-
>   libbtrfsutil/subvolume.c          |    2 +-
>   17 files changed, 495 insertions(+), 832 deletions(-)
>   delete mode 100644 libbtrfsutil/COPYING.LESSER
> 

Acked-by: Anand Jain <anand.jain@oracle.com>
