Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AE65282C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 13:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242883AbiEPLDs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 07:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242880AbiEPLDm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 07:03:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36A42B27A
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 04:03:40 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G8vQ40016856;
        Mon, 16 May 2022 11:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=VW6Roc+Nm3NcmD0UCBoB3sAa90jIpKOlqIwn/qqd09k=;
 b=HSU7r+mXff8Yv82XA5bbkH3X/ysKK51OZc7a/jLMwm825pynujYVh0rW9ds76EYIee75
 otFMH7xqTYlH8ugSLcGVpT1nh7JetlS0JrkTPkyyZkQJ8jOXUmmbEWaGAGseeaD41F6u
 8SZJGZD29HftIBfv34X210BFMJxp6fPQGYxHAcFWhwdkr7eFN+0/DR44XI5ghiPx1koy
 U6if8E1Kh41B+yG9xVMtNCquV9b9LyYzYvHReVYpGLO7UxDAa/5MaVA9iYtERGn3E5s/
 okIzYwy4AIUR3sckpbwC9DoMqZ56U4LM0wTf69DmpSqEUZQTnSo2W4fQbimYxCIBeLPC mg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aaawc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 11:03:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24GB1uFD020498;
        Mon, 16 May 2022 11:03:36 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v1n92d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 11:03:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAau5GkewJffmZXJM8oYRI8CqiKkOBkYCqb/eZlxIOAdBcBZkOVNOCJ9m2K9J4oeFfj5dWVpscfjbw7WKFJ3j/oUe759qkVwvE2UEBCTkx/dzlHnCMk/oSUGg8n9OgOCXLQUc8cbBpBI/xW78EV2tESvLsD4KHAiIj3ne3FIMhdk0fWP4MDhOvGAHC2mDdErExhpcmgKsCBlmXMCKAUy0epXw5ypvzkciBDiMiSV0TQ6rebMovnTFhVeSjOR7QWm72ChHi6toq/lndNCojxhFCPrrfIS0enCMtfQ7utn6WopxV2fz0r/RPnVjUbSrqOW6ZqcS7mIbK+AZ1ZK8OLWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VW6Roc+Nm3NcmD0UCBoB3sAa90jIpKOlqIwn/qqd09k=;
 b=obfjpQ7+EOXD72nmkOqXKe8kpC/o0P856YdDGu4gTLybWdtwJYD4vT1pTsB0N+NvSeFSLZnOitWhT0Ktt5KrpybRyBS/TOGYJFtxRlrfFmhaiQGHBYiEUymjuAj8uo4PreAlxR+X19oKio407WeWs4/joMX8y9Us7vyCmqZfH8iVhAFV69eCxo8KoF4N5w5QIdxwd/wHbH0Gjb9Ob9exUxceKwVosdBnx+gI1Hy9VKi9hLAdD5C4joNDi0Tpf4kAcriyrC3v6hH1uHP0ARVStEj7VHLFb3WRlLxsUrgaaT+CqPvgtIv7UHO0gJfMRqXoCqDcDeQ1y/yJm6ZpgUcOnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VW6Roc+Nm3NcmD0UCBoB3sAa90jIpKOlqIwn/qqd09k=;
 b=L7hD5brffPLXCtJJrbdDn4Y0B7LJEO1PJZomXdlJu2ptCltirAMTgEwVnr9uqsbir8bWjWCWta7BjxX3csuL6rTzHuiZe3cYdZ/CdKCBJ7W49fqz46A8u26ZbdN0zdbdtiH9ieynMq0KqX2YbLcErXVQ6lIY7oo2YnwII1hHFvc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1675.namprd10.prod.outlook.com
 (2603:10b6:4:e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 11:03:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 11:03:34 +0000
Date:   Mon, 16 May 2022 14:02:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     gniebler@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [bug report] btrfs: turn fs_roots_radix in btrfs_fs_info into an
 XArray
Message-ID: <20220516110239.GH29930@kadam>
References: <YoIFmTMuHork+zC2@kili>
 <beed78e9-ca59-636a-1503-cd10eca2b276@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <beed78e9-ca59-636a-1503-cd10eca2b276@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb94b65f-1720-44f0-4fed-08da372bb815
X-MS-TrafficTypeDiagnostic: DM5PR10MB1675:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB16751CC1FC81320AEA72D1B28ECF9@DM5PR10MB1675.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N7TmASWVq+1tzrisJV+IAClspFf/h96iMmyh3OwX07+MmYaVc5yqfo4QhdcqwiGQTw4V2I66qANVt7SJDTctGi1QCGBHr+kgZxOQ1RWJI1SSxjTdc+KtACHv/lbS3S3xZGzwn5fI4byMKne1xUJSdHH3ciX1Y/n1qsCdzVJ16939tHO6GAca+ujECBOPkVWzcK5uZuBBtFTzC43hvR8PLAaOCsU24EFpGU0VLz/iFwnmdnZtU5clAmQvOlON/Az4Qg9pBCOoK/SgWmuRIg+M6BQEusLhQbWyb1lkUd8dD+OlIV7zmhMiFDEIlWFnR6yQuEdPspRYF4woCLajp8cJlU+Z21RdWLo41P68hwlT3/MQTKs25oyIJLa1pVbGOlwuSXRhwTieOaCgYvdKonPeSPj3mefGo7CM9yN2yXeQxOjiuUKR40XBhnkJcoHS+be0m/CUaxGm7r+mwr7LcwZHbidEgbNSdhMztzSjYhz6c98now1R+VUtBerp1mtlQN7XvuKbP8YYYn/BhyFFsjPK5CN8NTt/yZJ8Vgwtr9sr5psMk7ldx1Uszo81GStdekC2yj0V1sLCpP7SW/sAfDtPkrLbgbdb7Fuucdn3e9ucUfcBaH2R9iqYSqycyi6SKFEGUJT+ES8S1H/A8q80jjnvw2ZCPYccS8IriFP+E1LSfAQpIs8KrdbRf+edfQutDHkOkfJNtsioNIOtVP+DxR03Sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(66556008)(66476007)(6506007)(6916009)(1076003)(66946007)(8676002)(83380400001)(4326008)(2906002)(186003)(6512007)(9686003)(316002)(6486002)(33656002)(8936002)(38350700002)(38100700002)(52116002)(5660300002)(26005)(508600001)(44832011)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE82RVZuZitzc01kQU8vNEQyekZFMEFDdTR6UmdxbnZMVW1ucVBKUEFEeUtZ?=
 =?utf-8?B?TXRXK25TZncxUHBWYTRKV3Bod3htWGJTYzEwUnFnczRtbTlaN0lFV1RGQm9v?=
 =?utf-8?B?eEl6eDZZNnJWQk1LNVZqQmZKR1ZxYjdPOGdkTFJHOWM1UDBVMGhPZzNjWG1m?=
 =?utf-8?B?azAxUTRnNThTZ1BZTVpsa3hhKy9yN3lVTmdXejdiVU9DTzlVTytPMzdsekZQ?=
 =?utf-8?B?UEt4LzJpb3l3eUFJbzNNK1duM0RHaFFyd29IcUtvcnNmcEZRdDN3NFVpR0U1?=
 =?utf-8?B?YjdYSFZrbHlaSUtpWjM0RlRXNy9jeTZaeVM0ZUdSMFN1a3ZveDVNR3B3a1Y5?=
 =?utf-8?B?Zks4d0dhUXdPZHpReTVHV2hQZlRaZ0JmcEhabGZHTlo1NTRKUGZKUGVDdWov?=
 =?utf-8?B?TWZpa3BuV3JWTXFySEtmZ3MzbElHTXlwaUVQOG5pMkFJaXFxWGN1MFkvTUtM?=
 =?utf-8?B?RjBsTEtMaTlGaVVLSmtZdHVMZlFOalVMU29qQ1FsYVN1aGEzMjdGczJzRHNv?=
 =?utf-8?B?T0RSNUxyVDVPc2owd2JiTEkwbm95UVV5Q0R3VURXemp5TW9JSW1CWUpsaWxt?=
 =?utf-8?B?NmRaVmE1SHFDL08rdVd2QnZnK0JUWlNwTU1jU01ZTGQ2UGl4dTlZUThRaGRH?=
 =?utf-8?B?TTlacXZMMmlyRERuMDE2eHh3NW50Z1daVzhtL1J4WlN4eG5DNHhQSVE1WFRs?=
 =?utf-8?B?cncwblIwcUtpVjJocXhTUEgvWmxmL1JqdWJyelpidlBVeGQwMXFqYUVTMFY0?=
 =?utf-8?B?L21hWU9qU05RQjdlejVSUU43NTh1L3cwSkJQNnFIMkFrVzJPbmtPcFB1VWVs?=
 =?utf-8?B?d3ZER3g0Mm96NWZmTmdpcDY5TUdDbUNBdjNLS0hma0tkTXhUNHNpcGxYbkVR?=
 =?utf-8?B?eTF3dXdPQnhLY3BLRXM5b0FURytpRVNpR29yT0ROdDBKRTV5V2tWdmozc2FW?=
 =?utf-8?B?dGlsSU5lUkZuNlJMelI5b3B2dTVXUlozOG94VWxtc0dGOE5aZ0JaUUFsRU1Y?=
 =?utf-8?B?ZXNIWGlCTmZ4R1JuL29LMTVUOXYxZGcvZ3EyWkN5VFMyV1krYjc5dGNLN05O?=
 =?utf-8?B?VW13RW5UbHEvUE5aeGdEbnRycUdzZEd0RnZVYkFib2JqRGxrT1lJbTBlSEl6?=
 =?utf-8?B?L29WRkFYOENwajRLeklwcWpKbXJRQmJhb1VRZ0pOUHR5YWJucFJZSGU3UFFu?=
 =?utf-8?B?K1pGRW96ZjYrYlhzYjBhR2p1N3pXSnMzQVN2akMxUWszQnhsWHM2YWhSNWdr?=
 =?utf-8?B?eENHbUkrdldLRjhoZzUzc1JXSnA2aDVUVTA4b3pwMFBWTWVjYTVPM2lyNW1N?=
 =?utf-8?B?djRVd0QwRGdkbS9qTnl4YWR6OFRiSUVGL3MxSVphWElJeElLbGFrbGcyMlJy?=
 =?utf-8?B?RThlS2c4ZmJ5UWg0R3hETGlOU2ZkMlNmajdiUmRrVmZDbG1RNnZ4STdBdjMv?=
 =?utf-8?B?K0h6UXlvZWFpSmlORlJNcmhQdCtuRFN4RkgyanZaRS80c2s3UDBIL1M5SHI3?=
 =?utf-8?B?cGRGTzZMcGpacTVBc2lqR1VETXBMUTVzOGp2MG5Tb0dLTlhHanBSb0QyYWxt?=
 =?utf-8?B?M1kwUStoaEQ3dXEyOStiVFBrM09HUERmQzJrWWZMTzZaamtFcW4xSVhQL281?=
 =?utf-8?B?bmR3U2ZJQ01ZQWRrQVpYRktJbUdyN3VUWktUR1kvdStyZmVqNlVLUkFUKzB1?=
 =?utf-8?B?Q3dyekZ1MGExZWRMVjdjSC8vZnQxM3VJa2pWb3FQZnBkbEtJUGNXQStDZGJ2?=
 =?utf-8?B?V1VIekFaM3duOE5SbzNDYXMrM2hvMjVjazREU1BoZUhnYllKY243V29YL2tv?=
 =?utf-8?B?WGFLUW0yRlhvMTRpVVNhRjZBUkQ2ZHpjcDNJVHdYYVhYZXRGaXFtY3EzR2tp?=
 =?utf-8?B?M1Qrd1c1VFBEQ053dGRrUHZXNXRxUFBkK01YVnpHWmpIcC9EVTJJZ2o3a0I1?=
 =?utf-8?B?ajJXY2ZKRVFPU0NkeHRWcUJBK1RvR3ExcVdPdU9KNU1adHo4Q0xZL2NmcXRu?=
 =?utf-8?B?elUzZ0h5UVFhV3Y2OFI5TE1tN0RXZi9hUkdWYXRwZS9FT2VUcFU4ODNTVFh4?=
 =?utf-8?B?UzJ3TVIxcm1rVS9GNkxvZnBLdnMyN1gvWEpkRWwrZFAxWC9XUU5UeHlPWW91?=
 =?utf-8?B?TWVWZkNiK3hncWRub2pERC9mSEFDZzJRa0lNV0J4MS9zU1NwZ043ZjZrWTlL?=
 =?utf-8?B?aHRRem9BcGpWUzVQcHA3MEN5SXdBd2p1U3M2WEFDYnBZaEJTOWFBYmRQTVpr?=
 =?utf-8?B?cXNGbWI1ZWNYRzNmSWlwYUR4NzNyazN2RUg5Sjg4aGVSempDTTU0Vml5ZCtZ?=
 =?utf-8?B?SWE1WTVGbW1ReWFpYnM3K0orYmFJQWFWTEFoR2RGOHlCUnk0a2pJUjk1aUFW?=
 =?utf-8?Q?PuZuMFoRwZV29xPg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb94b65f-1720-44f0-4fed-08da372bb815
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 11:03:34.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwmoLAxWHUHBrPsRuNH1EvbVdq9whzYVj1jG0DV8X6lMQzZCudKtONHNkDdAsQSi++DjHbV4+LoEhfjTRnjSmbukEChXfCraFIIg0jYVvc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1675
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_06:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=631 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160065
X-Proofpoint-ORIG-GUID: uJfta1zMMUjC0LDNI7qx80SKPnVYJzVN
X-Proofpoint-GUID: uJfta1zMMUjC0LDNI7qx80SKPnVYJzVN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 16, 2022 at 01:39:52PM +0300, Nikolay Borisov wrote:
> 
> 
> On 16.05.22 г. 11:04 ч., Dan Carpenter wrote:
> > Hello Gabriel Niebler,
> > 
> > The patch 06a79e50ff00: "btrfs: turn fs_roots_radix in btrfs_fs_info
> > into an XArray" from May 3, 2022, leads to the following Smatch
> > static checker warning:
> > 
> > 	fs/btrfs/disk-io.c:4560 btrfs_cleanup_fs_roots()
> > 	warn: ignoring unreachable code.
> > 
> > fs/btrfs/disk-io.c
> >      4520 int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
> >      4521 {
> >      4522         struct btrfs_root *roots[8];
> >      4523         unsigned long index = 0;
> >      4524         int i;
> >      4525         int err = 0;
> >      4526         int grabbed;
> >      4527
> >      4528         while (1) {
> >      4529                 struct btrfs_root *root;
> >      4530
> >      4531                 spin_lock(&fs_info->fs_roots_lock);
> >      4532                 if (!xa_find(&fs_info->fs_roots, &index, ULONG_MAX, XA_PRESENT)) {
> >      4533                         spin_unlock(&fs_info->fs_roots_lock);
> >      4534                         return err;
> >      4535                 }
> >      4536
> >      4537                 grabbed = 0;
> >      4538                 xa_for_each_start(&fs_info->fs_roots, index, root, index) {
> >      4539                         /* Avoid grabbing roots in dead_roots */
> >      4540                         if (btrfs_root_refs(&root->root_item) > 0)
> >      4541                                 roots[grabbed++] = btrfs_grab_root(root);
> >      4542                         if (grabbed >= ARRAY_SIZE(roots))
> >      4543                                 break;

breaks out of xa_for_each_start() loop.

> >      4544                 }
> >      4545                 spin_unlock(&fs_info->fs_roots_lock);
> >      4546
> >      4547                 for (i = 0; i < grabbed; i++) {
> >      4548                         if (!roots[i])
> >      4549                                 continue;
> >      4550                         index = roots[i]->root_key.objectid;
> >      4551                         err = btrfs_orphan_cleanup(roots[i]);
> >      4552                         if (err)
> >      4553                                 break;

breaks out of for loop.

> >      4554                         btrfs_put_root(roots[i]);
> >      4555                 }
> >      4556                 index++;
> >      4557         }
> >      4558
> >      4559         /* Release the roots that remain uncleaned due to error */
> > --> 4560         for (; i < grabbed; i++) {
> > 
> > This code is unreachable now.
> 
> How is it unreachable, if we error in the middle of btrfs_orphan_cleanup,
> we'd break and this loop will cleanup the rest of the roots,

There are breaks inside the inner loops but nothing breaks out of the
while (1) loop.

regards,
dan carpenter

