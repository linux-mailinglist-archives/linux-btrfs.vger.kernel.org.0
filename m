Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C461E1147F4
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 21:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfLEUI2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 15:08:28 -0500
Received: from st43p00im-ztfb10073301.me.com ([17.58.63.186]:37950 "EHLO
        st43p00im-ztfb10073301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729145AbfLEUI2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 15:08:28 -0500
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Dec 2019 15:08:28 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1575576043;
        bh=6Ub3BkQvHQx1uppbjHiWK52OFPrxTil+a1PkxyPOOqU=;
        h=From:Content-Type:Subject:Message-Id:Date:To;
        b=aVpwgpXQ0Cn3K33Q6/hamwMq8wyMi19RW0a5JWwoHh9Cv2vdL7WdAKAXBJKCMRG3G
         0fjVi8awsmjxr05UYuImJiGCpVcBQCQ7BFrDWdFH+HRIkDE6DJjk73DtEYGZirxhe+
         fhoWrTu64hzsrTu/lTG3HWRuwaEFXLNMkSkpkxLvfRLEnWIgTKRAh+edxWFNIrGDD/
         9SByempza9YKW+1XxK8VGGnh9Fp8rKdv9TH0Up0XKfnfzVtqcxv8nssQOLJRtEqEud
         0DIaP36hS6PU6qhI7vBxT+AScgKAAC5V5G0P/F0voRfUSNugj7zn96267hcynsP/sC
         ZNj1117/wBCdg==
Received: from [100.98.43.211] (unknown [5.62.51.38])
        by st43p00im-ztfb10073301.me.com (Postfix) with ESMTPSA id 748CE94147D
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2019 20:00:42 +0000 (UTC)
From:   Christian Wimmer <telefonchris@icloud.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: is this the right place for a question on how to repair a broken
 btrfs file system?
Message-Id: <A01B0EC4-8E96-486B-A182-76B74AD0F97D@icloud.com>
Date:   Thu, 5 Dec 2019 17:00:40 -0300
To:     linux-btrfs@vger.kernel.org
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=570 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912050163
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, my name is Chris,=20

is this the right place for asking on support on how to repair a broken =
btrfs?

There is no hardware problem, just that the power went out and now I can =
not mount any more.

Who is the best specialist that could help here?

Of course I already scanned the WEB some hours and tried all =
not-destructive commands without success.

Thanks for any help,

Chris

