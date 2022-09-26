Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B775EAE87
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Sep 2022 19:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiIZRt7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Sep 2022 13:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiIZRtW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Sep 2022 13:49:22 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DCD8E0C7
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Sep 2022 10:21:40 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QEnKYC015846;
        Mon, 26 Sep 2022 10:21:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=VjwRHXMgyvnxCjUUr4qUq2CYrdB88alwS2wW+4+WN+M=;
 b=TeJXMuP2minFDbJE52UckndGxv6CP3SN5Y/7zFMqkES1wRvC59nNNBcSLQM5NkqmS0W9
 4pVG2WbTPiM4B07fYz4dxgJGwA/qBoHC62tIshd91DsBNGmpyJi2No2jl/PyjDaPg+0v
 60BuAXOLhq5XuSFkwzMCjfvlGS6kgdwzwqw= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jsydxvhpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 10:21:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELUHCkN1EgbeVENHm4YxUR3n7gpZzbRHZvu+Nme6w7/sWqELoIw6VeVanMdK7MshNO2VJff1mqOS8ZAHy+aNyA+9lxWYOF9URRd/jTMwf+SKg7NmCk541Ykbp9C8wf0ZRIPqd8njZDTqINKp4DN93RVCixvDxPSIREeUM0fsMZReqlCp9VuWIOcfR9tRpXjkhWKAKE6LgjYcNcNWJBaYXmvHh5HnweUZ6w/xvE7n9vam3HbjzlRoMkYs2N1lbb3qmXH4T3cHKGE/dWmZ4Q/IoHGFfh98l2yo7v9uDWLYb3YIWU3J1fpo2Y4YS+fGmQyborKU5JqTn4bklMGI6HUKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6kWYFC+ry+C3JMGMmpgJsk3eQ12F3/Vi8q1oJSWhOw=;
 b=FAAfk/05fa3cQDloo3bbOMF6yt8USz1+FVVvl+wzUPOsTdn+Z+n3U0MMvDQoffi8SmK/h5/qK4uUZhlzlwnQN1mnl1Es4AuZK6tO1EeQR4Eg0ycum9s0nU5TxcteG5fgAk7emEhbb7IqJ5J8ki8bjz+5XYpJApiecSEbWUcgO4QpW8xfmgsY04RrPb4yX2RzqIHS2mK8e0w2Y7vy3i3Nl5FZ3dt82Nwu6Y43YuUsa+k4YcF7p/I5L2WqyB4m61agZYevIT527GGLnxCjtpoKgOGrdcosY4ogDUp3ZtwxAMRhn6is/oSD/E53rPzF3nbrzWveCqJKXKITEvf5x/m+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB2316.namprd15.prod.outlook.com (2603:10b6:5:8d::10) by
 BLAPR15MB4019.namprd15.prod.outlook.com (2603:10b6:208:274::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 17:21:34 +0000
Received: from DM6PR15MB2316.namprd15.prod.outlook.com
 ([fe80::f282:1090:1e56:d662]) by DM6PR15MB2316.namprd15.prod.outlook.com
 ([fe80::f282:1090:1e56:d662%3]) with mapi id 15.20.5654.020; Mon, 26 Sep 2022
 17:21:34 +0000
Message-ID: <37479a58-5075-919d-133c-c09058300115@fb.com>
Date:   Mon, 26 Sep 2022 10:21:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [bug report] btrfs: enable nowait async buffered writes
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
References: <Yy3IUPYheKipaIei@kili>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <Yy3IUPYheKipaIei@kili>
X-ClientProxiedBy: BY3PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:217::21) To DM6PR15MB2316.namprd15.prod.outlook.com
 (2603:10b6:5:8d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB2316:EE_|BLAPR15MB4019:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a154cf-816b-418d-7f63-08da9fe38f61
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGt/B2StdW+ygMGA7XHtK6UQO0bkUf/plljOjvQM0+9S9WNTsn+epScs/wJ/xXBqHqiphJJC+hijt0JUEGrK5OKF2o3Ewe9xPa/GcY1NRTuoIV//IrAiDa+lXZHBix2PmoeLkMy2anYZN/YcOx1p4lgKk4Eg00i1tZU5UhStlIm9HJUxaAguqU/iXts5GKCMt2TGCiUuKKmUTvogUU/TqjAkJuXpC8TWR0nYfqiT0ra/1ZIpQbdSBl1RWuVard2etSH2Q7VNvo0/cxSHJRAxh8dO837S9E1Fvtng+wCbhBELBOTG3YJ3gecODf74Zz08i9zGR6aeCfgPqjTzNVUc+3u2yvJ2s6n5wpGOmNnvCxpN+gGpzITacP82xQreJSKgBHqwSsl/8eYHbzPbkhlQHbGPHNjndtuKdZj+S2AyRqgQyls0bTF6tKvl5a7QQV/SAOm2SU2Tmhdq8TcKolsdRvRYlV8ysZcX3QczPAtittEFVQ/XwQwtwXUcJA149z/DQGSHfJbN+x8fTRc/t9bIVY2LeCFKA2kNtIf6/vZ2dn5uRcEstn0w0Ww8gdjs1XBdk2nzPD/E697d3p93ZC4g7bgmGswS+0ZtpUqPxxfiO8e31VGuzMlXAR+Ohf16L7WoIwPtq5bZgcnp/g0kiVs7E9Q6wcivZFTWTBRix5G9pIwTP1d/QoRYezpYPrnnRkfPOQUDjkqAIQOOnMvoLzd5jirPLN+oD9pfUOrJoRy7UvYGCn65tNyDutycC73gI+FjC2iUrIXnS+RNIOgqYJ5acyUW+QYA73slmbV2UtJvZUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB2316.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199015)(6916009)(31686004)(6486002)(316002)(478600001)(8676002)(53546011)(8936002)(6506007)(5660300002)(41300700001)(6666004)(66556008)(66946007)(66476007)(4326008)(36756003)(2906002)(186003)(6512007)(2616005)(38100700002)(83380400001)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2pWVGdDQ0libTJrWGlnVEh3MzhQckZMTDNOa1dZK1NmdWN2bFBaRFZEcVdt?=
 =?utf-8?B?REZTMSsyQWF0WmZSaFlTV21GakpMMkhUSUIzc3ArVThLWTFUMnNETUxrcFBI?=
 =?utf-8?B?MGpTWGNRTk96Ni9raU0wSm50a2hYdVVFYWdONmR6cXlxY2gyS05Dc2JBK0ti?=
 =?utf-8?B?YzBnWmJIVUxseWZHSTRUY1BPR2ZUSU92RGFBRVpNUitydW83RHRMd09oZThP?=
 =?utf-8?B?OThpUjRvUTgxbVEyU1doY0pPVDdTMWcwL3VJeTE4YUFZeDcvR2MvL1VYbVRD?=
 =?utf-8?B?dDlLZEw3TWZnRXVOeTVTZisxSkYyeGthSXUyM2xuVldudTRoSlB4QVhkOVJv?=
 =?utf-8?B?bDJ4d3ArcjhtSFg2OHlBN0JRZ1RCR3hGNktZb25VNXgzc0I2cDh2cDVYSGFl?=
 =?utf-8?B?d0dncENqYVhnK0dBL3F1Tm5aRXp1Z3pwNXQ0d0JjNkUvM0RYOXRsekJaZzYv?=
 =?utf-8?B?SURCdWE4eFcvRlZEQnNaV3lrY0x0a2MvYWk3WkFEeXRDVTJwUEZibmFrSita?=
 =?utf-8?B?OHR6NFpOQjFxNGRDVEFJOURoT1lFUUJqand3UTBiUElGZTZreFRTS3BJemZE?=
 =?utf-8?B?RGhmRGw0WjVTZEdhYUR6aUtEWHVKa0JxQ01LV2o3QVR5YmRJYzZkZHNIbzNS?=
 =?utf-8?B?N0p5ajNYekVsZGh0QjV0MnRydDFMdmNwVG5RY1pIUlZqdEVSZG1tdHhUbzVo?=
 =?utf-8?B?UEtDZmFMNlNGSTBsNUE5Z1lLd0huSnVMcDlPZlpJN3UxNXI4RlkrSHNwUzFK?=
 =?utf-8?B?YThYTVcvdjM2bzlkbmoyNkE1b3lLOFJaZFlzZEVlcU4xYlZ4ekp3ZWkxSG9r?=
 =?utf-8?B?V1lyVjZ0OXhIbEY0dXE0ejNrMjJhUkRyWGFNQStJRis1YjZZeFI5MGdWNXZO?=
 =?utf-8?B?dXNUdTRwdnpJdW1hL1dkL2lFSFZnamo4aHdBelhPSHQ2Vkh2eXVyZDUyK0Mz?=
 =?utf-8?B?T1RkcHhSdTVlS3JIbXhVMVdNUEQxc2xOTXMvbjZKL3pvV1F6bzRFWlJzbFd6?=
 =?utf-8?B?U0tDOHgycG1jVTVqWTJLci9KRnBSTVE0SklIMnhmN2J5djRYSXVvN0gxbmZQ?=
 =?utf-8?B?YTkzdFptQS9VUGdhTlZ4ci9RWHhxQlorOFBsNHVxc1RtNmxQenBIYVoxZHRF?=
 =?utf-8?B?eDJYMUtnNzcrZ2EvK1B6dFAzMFYwcHBHOWlTSnJ0VWRaOXpVK2wvTlBRbGgx?=
 =?utf-8?B?bUJNbE1LQ0srbTcxS0ZEQzRCMXA2Vmx3aG5PaHBFM0gxV3JLZytDYWQ4Q0Er?=
 =?utf-8?B?WEZDendhVElUZWF1d1dBNitNaisrQjJEbG1iM2JZelRMdU0va0hNWnFGajV2?=
 =?utf-8?B?ZkFGZVJRRXJVaFREWnRZSU5rRGd2aE9ZZUYxUXltRjhxSmtsdnhkSy9Tam5w?=
 =?utf-8?B?UlJxdWJBU1kwdXVYM1dJeDJma1BGNGg2Y3dkR0RCcWlUZFJRWHdJNlZIYWNF?=
 =?utf-8?B?MGVMZUtLcjh5dkMyNkVpUFlLVmtuZTlTUUtMYVdUcUU4d2p2MjdCVHZCRGx5?=
 =?utf-8?B?K2ErU1A2K1JxT3Ezc0FIKzRYaHVNQUdBVXYyTVErM29BbFJXSXB2c2hJaEgz?=
 =?utf-8?B?RG9acFpCYWxoWUk1OWtOSTk0cHBoOHBKbk1pb0pROFhjeW5XMUdGTDYvTzRo?=
 =?utf-8?B?c05EMjhmVEpicHZPdnF0U01EdnU5VE9XbzlDT2xmWkhMK2RjZmlJcGw2andB?=
 =?utf-8?B?RDBhejBjMHNwVVk1RVpaL2QvTmJNVGUzVFRHcm1ZK0dheWpYVmo2UVZTdEVx?=
 =?utf-8?B?RXBkQnIyZjQvVExsUDJtNDR3S2krVjBGSkJSZm1zQzB3M1BVNGVHQkRKdnFa?=
 =?utf-8?B?V2N5YlJlczRGRmdsejhROWtwRG94U28vMzhCZloyYkFrRlZGenhpTlc0d0RV?=
 =?utf-8?B?ZmQrenc1Rjc4TEVIS0FIMHR1UjVzWVN5SHNocjlIWVBDWXdTZ3gzNnNWcllZ?=
 =?utf-8?B?Nyt3QjlHeDZsWGpjVUUreDc0RXRVenFEd2tJQStidFNtLzZwMnkvWWpCeFhM?=
 =?utf-8?B?OHlBSHQyNy9MUkNFMExlczRWQmJ1aFB0OFRSNzRKU1lYTCtKMjRuaFRQTFNu?=
 =?utf-8?B?R2NGY1R6NVUvOWFLdEtHRVlFRW03QTMxMEIxaTFyTXdVU2ZyaU1kaHFmNjZF?=
 =?utf-8?B?K0QzY2QwbXhlN0JwaWlYaHJEUWFJWHU1ekdCZHhHRDBGZkpLeTBKenNnNDJC?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a154cf-816b-418d-7f63-08da9fe38f61
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB2316.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 17:21:34.0145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUgM/TKlmIUBK3CqMQTEBpTmcfkKdVpjsfgLwJtVmujRs/8nNbijrbLKKTlek0X6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB4019
X-Proofpoint-ORIG-GUID: y2txKIYVjoQXJMiAvhmyZoG5JasYFKMg
X-Proofpoint-GUID: y2txKIYVjoQXJMiAvhmyZoG5JasYFKMg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 9/23/22 7:53 AM, Dan Carpenter wrote:
> >=20
> Hello Stefan Roesch,
>=20
> The patch 8bf465b1c880: "btrfs: enable nowait async buffered writes"
> from Sep 12, 2022, leads to the following Smatch static checker
> warning:
>=20
> 	fs/btrfs/file.c:2113 btrfs_do_write_iter()
> 	warn: refcount leak 'inode->sync_writers.counter': lines=3D'2113'
>=20
> fs/btrfs/file.c
>     2092 ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter =
*from,
>     2093                             const struct btrfs_ioctl_encoded_io_=
args *encoded)
>     2094 {
>     2095         struct file *file =3D iocb->ki_filp;
>     2096         struct btrfs_inode *inode =3D BTRFS_I(file_inode(file));
>     2097         ssize_t num_written, num_sync;
>     2098         const bool sync =3D iocb_is_dsync(iocb);
>     2099=20
>     2100         /*
>     2101          * If the fs flips readonly due to some impossible error=
, although we
>     2102          * have opened a file as writable, we have to stop this =
write operation
>     2103          * to ensure consistency.
>     2104          */
>     2105         if (BTRFS_FS_ERROR(inode->root->fs_info))
>     2106                 return -EROFS;
>     2107=20
>     2108         if (sync)
>     2109                 atomic_inc(&inode->sync_writers);
>     2110=20
>     2111         if (encoded) {
>     2112                 if (iocb->ki_flags & IOCB_NOWAIT)
> --> 2113                         return -EOPNOTSUPP;
>=20
> This check used to happen before the atomic_inc(&inode->sync_writers);
>

Thanks Dan, I sent out a fix for this issue.
--Stefan
=20
>     2114=20
>     2115                 num_written =3D btrfs_encoded_write(iocb, from, =
encoded);
>     2116                 num_sync =3D encoded->len;
>     2117         } else if (iocb->ki_flags & IOCB_DIRECT) {
>     2118                 num_written =3D btrfs_direct_write(iocb, from);
>     2119                 num_sync =3D num_written;
>     2120         } else {
>     2121                 num_written =3D btrfs_buffered_write(iocb, from);
>     2122                 num_sync =3D num_written;
>     2123         }
>     2124=20
>     2125         btrfs_set_inode_last_sub_trans(inode);
>     2126=20
>     2127         if (num_sync > 0) {
>     2128                 num_sync =3D generic_write_sync(iocb, num_sync);
>     2129                 if (num_sync < 0)
>     2130                         num_written =3D num_sync;
>     2131         }
>     2132=20
>     2133         if (sync)
>     2134                 atomic_dec(&inode->sync_writers);
>     2135=20
>     2136         current->backing_dev_info =3D NULL;
>     2137         return num_written;
>     2138 }
>=20
> regards,
> dan carpenter
