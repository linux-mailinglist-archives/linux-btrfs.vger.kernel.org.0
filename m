Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D8324DEAF
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 19:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgHURkX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 13:40:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:43645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgHURkU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 13:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598031619;
        bh=189kxbu3XzcNu3ekt4A/SDhBBtAu7oa5OqRCusG7prM=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=asHCi8hs51IGoRUaNW5As0lOvE1IB3sl2+KFtss5lKj3N5C0XUGB+J3nktZFMg+Wp
         lWv/DLsTdc4BE48JVkCRh/xdt9JCvtDUmI6MexGOkT/DYhVjb6UAndrbbPpR6H2JJ8
         LhGCm1gFT3vbYtj8X8Eu7dE1MLFuAQwg6JsnPurM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [89.245.123.82] ([89.245.123.82]) by web-mail.gmx.net
 (3c-app-gmx-bap35.server.lan [172.19.172.105]) (via HTTP); Fri, 21 Aug 2020
 19:40:19 +0200
MIME-Version: 1.0
Message-ID: <trinity-57be0daf-2aa0-4480-a962-7a62e302cfde-1598031619031@3c-app-gmx-bap35>
From:   Steve Keller <keller.steve@gmx.de>
To:     linux-btrfs@vger.kernel.org
Subject: Link count for directories
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 21 Aug 2020 19:40:19 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:vIrrw0dPu3cgTxFn2x9NyttR5z520fX9CvkAS0tD/24IcoQdHNpNht2O8ACjOT8ClNilt
 5FWdGmwL78hkXg33CFFxllQkLRe7Crxyag5m1Ur5LnMkU17OlnyY9d3QzdYwsbcZ0hSJseNLOST5
 KGXpKbmUg3Tn+GYVV9CjQiu81Lr95WqhWcC29GnbZ8WhbPhwUGQ6qAx5tQbE0ndFeCtVv9rv0s1P
 l6mPyivRGX/KaEpb5AiIMX3hXc94mtw1HU6fA1YAKT7YEwwFxnKPjyZMh8F1YRzUykosqi45kyNT
 jg=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8frIhO1jMDk=:K/xjrjQmNLs01Ex2mzUfGq
 kO8NYk4JWsHnjV1LrTc5lC3AlgMkZfCp/ZleHWI0lu+dxv6jsiuKpolyKd3lEJU952GIcfzeg
 /BTQkd/VpA9JEmfKnP7Z7jysCqpPoCgHjBVLgF98piYgBfEBU/zYA62nbmePqXtBuh2MSnYf3
 gfJOtX7DHFQscNuf1eha8lJTkyBBbAJpZXH5PcW6r/d+xCgEC+JG70WBEYQNf1QnNe9P9J8ek
 cGvSK8T4yOUiAQhMFcBRViPYmZ7bi6TWeN1ptkipQVz3pHNOqkFziYJne0ilytEiZn6goKonQ
 h9c9Uq9QX3m+KI8TOrcYM2ArG+NDo85C/7Jf/uSBONVk3GViz/sS2PsnjtojG1FB1LJzeOmeN
 G4KHYei5oKAJp+FbEtePDe4aFc9W5JYINa0JO/x1dZbQi8kkxDsVtyD1Uhih8VcuhQLNvGPHS
 tLmgIiC+KAc6/Ptty2MHJlFR4NzJ5q02Y/FMj2GCqGY9ALPWgGvsmISaFIWkkL8MVXXavi10r
 lNDf6AJFdFb9Nn29nsKUtw7zLSt6fhJDh1KJT1wVeEbMGjVypcK/0RlLLmcAD8wuRT0T465bK
 +mcHwzBgCXAfd6rs4E94OnF5h/G8UA7ak2pVMd78Dz2EL/XKufkl9rLw0tLcl+/3662cYTsl1
 t5Ix7zSVQl01m5qOVdOF8DYU23LWN7axXjGN77VSGWmJQl2aKfxgwZYMPLBgWBq3ASSc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Are there any plans to implement the traditional link count behavior in btrfs,
as described in the following URL?

https://btrfs.wiki.kernel.org/index.php/Project_ideas#Track_link_count_for_directories

Would it be a major effort to do so?  I'd really like that feature.

Steve

