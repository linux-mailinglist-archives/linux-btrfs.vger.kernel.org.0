Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE8074F590
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jul 2023 18:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjGKQdk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 12:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjGKQdH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 12:33:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5422110CB;
        Tue, 11 Jul 2023 09:32:55 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BG3O1f022902;
        Tue, 11 Jul 2023 16:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=+4V1nFRqwTelDtAcI310e7e7t3xc9C8kzlyU277DNxs=;
 b=ymbOEdbzGq63lkQ0RO+iBGkUQEcS4UO/lxjF5K2PqFLto+ysV4TEsKigi8pkSD+0XbV3
 XL1VOnexhj0u4/lo6XBn/xKbWSCP26vhMmRAizm8IRK0RiyBmzMxWVgii4+mt2saQDoe
 WQkfBM6MOBixvv4+SnNsom8ajpTprr/jzywgI6bM0UJ9nti/578BpsbF+a3T3kS3400U
 qjrAwqeuyDNTIGrKLmM9yjvATi3gM7M2TcV35rsN6hK23qmhlVJ+Q2GA+3HbmZr/Ok6j
 74UXMpMsv5v2yolmJdhg0gscYbkGqAGt8XqOJSHUbr49tqGPzkT/fCW47BE+ftkelpr9 sA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpyud5e6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 16:32:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BGUtBm007087;
        Tue, 11 Jul 2023 16:32:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx854cdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 16:32:03 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36BGQBXP019529;
        Tue, 11 Jul 2023 16:32:02 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3rpx854c4h-4;
        Tue, 11 Jul 2023 16:32:02 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-hyperv@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        kernel-janitors@vger.kernel.org, keescook@chromium.org,
        christophe.jaillet@wanadoo.fr, kuba@kernel.org,
        kasan-dev@googlegroups.com,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, iommu@lists.linux.dev,
        linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-scsi@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org, John Stultz <jstultz@google.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Liam Mark <lmark@codeaurora.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Shailend Chand <shailend@google.com>,
        linux-rdma@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-btrfs@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-sgx@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/24] use vmalloc_array and vcalloc
Date:   Tue, 11 Jul 2023 12:31:45 -0400
Message-Id: <168909306205.1197987.4062725942946508296.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627144339.144478-1-Julia.Lawall@inria.fr>
References: <20230627144339.144478-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_08,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=801
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110148
X-Proofpoint-ORIG-GUID: VdiqWRAD5JOoA45uglvHtoSxe29wDWJY
X-Proofpoint-GUID: VdiqWRAD5JOoA45uglvHtoSxe29wDWJY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 27 Jun 2023 16:43:15 +0200, Julia Lawall wrote:

> The functions vmalloc_array and vcalloc were introduced in
> 
> commit a8749a35c399 ("mm: vmalloc: introduce array allocation functions")
> 
> but are not used much yet.  This series introduces uses of
> these functions, to protect against multiplication overflows.
> 
> [...]

Applied to 6.5/scsi-fixes, thanks!

[07/24] scsi: fnic: use vmalloc_array and vcalloc
        https://git.kernel.org/mkp/scsi/c/b34c7dcaf311
[24/24] scsi: qla2xxx: use vmalloc_array and vcalloc
        https://git.kernel.org/mkp/scsi/c/04d91b783acf

-- 
Martin K. Petersen	Oracle Linux Engineering
