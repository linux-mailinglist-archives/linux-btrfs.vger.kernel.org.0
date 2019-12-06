Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 080391158A0
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 22:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfLFV3A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 16:29:00 -0500
Received: from st43p00im-ztfb10071701.me.com ([17.58.63.173]:60779 "EHLO
        st43p00im-ztfb10071701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726370AbfLFV3A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Dec 2019 16:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1575667738;
        bh=pL+z+9nZmzpHg/d1Dv71HWMhjzhH/1EWAAlR6eS3dXA=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=0eL9RxENPnc0ZO74gbnNBuDCCnBZyl17SgE0F/kBPXnaKZNfrsHVUNbGvTClz57qG
         GSlSNX3cZrsEXzGtdjidnaXIlxkWztGCMa0pSUn3UYnC8Kg9WDZy9/Zdizagoe+8nw
         dmVH9tOyWeCzYaT337ZZyx2946YHVY0/EL8UUtuiQA8WKq5m+2B18b3DAB+rchRTZd
         iPmDN/J6JPhOozwayto09r2eul0zyCPABICz180WpIF7K8ntvQ9BcM4ARVxoXzZprh
         DlfKhbqeZMCDuLJ23xZ6j1GbamanQLxr8MQBh6zI6oROTgqsx6xDKsel1gLKMsY8QY
         MCqPFcljqG27Q==
Received: from [100.98.44.246] (unknown [5.62.51.87])
        by st43p00im-ztfb10071701.me.com (Postfix) with ESMTPSA id 11936AC03E1;
        Fri,  6 Dec 2019 21:28:57 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: is this the right place for a question on how to repair a broken
 btrfs file system?
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <6c1cb788-33b9-eff4-ca0b-7c2ac6b73841@gmx.com>
Date:   Fri, 6 Dec 2019 18:28:55 -0300
Cc:     Hugo Mills <hugo@carfax.org.uk>, linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <014BD263-FD4B-4561-ACD8-6A94C4EB9B65@icloud.com>
References: <A01B0EC4-8E96-486B-A182-76B74AD0F97D@icloud.com>
 <20191205202449.GH4760@savella.carfax.org.uk>
 <61D37CED-8564-49BC-9388-4A8511C3AC50@icloud.com>
 <522495ca-ed55-dd81-a819-dab93e67d0aa@gmx.com>
 <DBA30D34-E186-4359-A8C5-C13C870F1D81@icloud.com>
 <6c1cb788-33b9-eff4-ca0b-7c2ac6b73841@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=896 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912060171
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu and Hugo,

I think all the emails to you were rejected by the your mail server.

For this reason I am writing here in plain text what happened.

I could succeed in compiling the latest version of btrfs-progs and I =
applied the patch you sent and I got a lot of output.

How can I pass this output to you for analysis?

Thanks for your help,

Chris

