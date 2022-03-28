Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13794E8C9F
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 05:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbiC1DbZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Mar 2022 23:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbiC1DbY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Mar 2022 23:31:24 -0400
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Mar 2022 20:29:45 PDT
Received: from st43p00im-ztfb10061701.me.com (st43p00im-ztfb10061701.me.com [17.58.63.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F5D50E1D
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Mar 2022 20:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1648437879;
        bh=y85VLtyBoiTcSSXSLQCNSWM4vMl8TCDm1OZ6YkjgU40=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=OGBtP7znk/CpnbTCmJdXsiUeGAsPPQPUKUcsYsRtWDqtA68+X65Sgb+6VYf55ooz3
         VTsoMjbnR4dgpPqcHq92JXsEvlsuoat6is/q2OVLSHadHgDww4hXtmxlVMcm8Dp51s
         jHgrx4pq7/D9fBU8met289wrGMtZTyWWL5jpt9Sy1B2Flurc1wHduml2GZ8fOwM2RS
         +0BS8xvJZ52N7WS2oYG7QXTeI6tENiK8QY1F+9tIxxe6IydGw9ANoVc2IuzYBatWTI
         kIH7Nb5Jh2RtiaGVliXxqQDUvNBk1ahRzo8MVj+TTvEa+vifquDwsgAdREhVPp9wEx
         ywoTOX7JR++cQ==
Received: from [192.168.6.187] (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-ztfb10061701.me.com (Postfix) with ESMTPS id E27A52E070C
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 03:24:38 +0000 (UTC)
From:   Alex Lieflander <atlief@icloud.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Ref-Linking across multiple mounts of the same filesystem
Message-Id: <5790FFB1-5F16-4E2A-9132-41B8FADD428E@icloud.com>
Date:   Sun, 27 Mar 2022 23:24:37 -0400
To:     linux-btrfs@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-28_01:2022-03-24,2022-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=444 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2203280018
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I=E2=80=99ve been using BTRFS for a while now, and absolutely love it =
and CoW in general. Unfortunately, I=E2=80=99ve encountered a limitation =
that conflicts with my desired usage; it's impossible to create =
ref-links between (or efficiently mv) files on the same filesystem when =
the roots of both paths are mounted independently.

Suppose a BTRFS filesystem has two sub-volumes, =E2=80=9Croot=E2=80=9D =
and =E2=80=9Ctmp=E2=80=9D. =E2=80=9Croot=E2=80=9D is mounted on / and =
=E2=80=9Ctmp=E2=80=9D on /var/tmp. You could not successfully execute =
"cp --reflink=3Dalways /home/alex/big.iso /var/tmp/big.iso=E2=80=9C. In =
order to avoid duplicating the files=E2=80=99 extents (via cp or mv), =
you would need to mount subvolid=3D5 of the filesystem somewhere else =
and then use paths according to that separate mount point (like =
/mnt/system/root/home/alex/big.iso and /mnt/system/tmp/big.iso).

Is this a limitation with BTRFS? Or with the Kernel? The user-space =
mount utility? Perhaps there is something I could do to enable this =
feature where it might currently be disabled.

Thanks,
Alex Lieflander=
