Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C284115581
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 17:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfLFQek (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 11:34:40 -0500
Received: from st43p00im-ztfb10061701.me.com ([17.58.63.172]:40945 "EHLO
        st43p00im-ztfb10061701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726321AbfLFQek (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Dec 2019 11:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1575650079;
        bh=NJEx5vrOa2TgYHJr+SP8sf5DGLx2BM1vwBJ27fnLNvU=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=QZTdpF4Zqew0Ss6olo961Yv6hIM107DuytrUWA57SsABeb+aHOj4CBOg2hZrR2AEh
         vrKR+CoRTZGwHNbHj7EEKKv0+xSMgI/tq/VhspQ7v4C8N7KzOouc8S3kQQmnAq6/je
         5jmxzPOkf2oL8sdm69WD0yoxdQ7eBn4yDnJ1IOsoPiEyhFNAQPQQmDm6FCCxv5agiI
         QSGMtgQ4qduO8c9jhaI9R3em5IWlLhnBH0Y6ca2fyqIEijbMgMk+Wv4P3rkCi6KgjN
         MNdHokH8abNqtcAnbvtrclj0NXTICyWqatu8XAkOKR6LpjE2TbGUd2+0x2aszxDE/P
         6127k0zX8Hh5A==
Received: from [100.98.43.211] (unknown [5.62.51.38])
        by st43p00im-ztfb10061701.me.com (Postfix) with ESMTPSA id 9D677AC11B9;
        Fri,  6 Dec 2019 16:34:38 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] btrfs-progs: Skip device tree when we failed to read it
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
Date:   Fri, 6 Dec 2019 13:34:36 -0300
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <434308E9-4A9E-4985-846A-3185B478DA12@icloud.com>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
To:     Anand Jain <anand.jain@oracle.com>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=572 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912060137
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Anand and Qu,

seems that all mails to you were not delivered because of the attachment =
or the extensive body.
How can I pass the information to you for analysis?

Regards,
Chris

