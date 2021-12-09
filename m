Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F169E46E8AC
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 13:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbhLIM7x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 07:59:53 -0500
Received: from mail-m974.mail.163.com ([123.126.97.4]:57658 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbhLIM7w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Dec 2021 07:59:52 -0500
X-Greylist: delayed 908 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 07:59:51 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=VlLxX
        xIBjKmKOXhxHcJX/xpUu5HLMFirH1D3GYwu9L0=; b=Jh51xSlBvEYdU3UjBqPMR
        JDs9Fn7hTqqJRi6iwh9fWAqP5WDeZ7mvy2AwstfZjn+TTilCA/sIU0TdEZztAbHW
        ajHisDYK+3SUOUUnoPDBnCZqSfVd31OCl06k0HjKKZ4erWIiKEsPBUYAXczg0HfU
        Ym8qUR1QGdqet3fLoL3XuI=
Received: from localhost.localdomain (unknown [218.106.182.227])
        by smtp4 (Coremail) with SMTP id HNxpCgAHBhMq+bFhVkxTAw--.8414S4;
        Thu, 09 Dec 2021 20:40:30 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     quwenruo.btrfs@gmx.com
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        niejianglei2021@163.com
Subject: [PATCH] btrfs: Fix memory leak in __add_inode_ref()
Date:   Thu,  9 Dec 2021 20:40:07 +0800
Message-Id: <20211209124007.7210-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9d299505-a334-b988-2fcd-bc2129207959@gmx.com>
References: <9d299505-a334-b988-2fcd-bc2129207959@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgAHBhMq+bFhVkxTAw--.8414S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU3iSdDUUUU
X-Originating-IP: [218.106.182.227]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/xtbBOR5kjF-PKSDp6QAAsW
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I did a static analysis for the Linux kernel using the clang checker

