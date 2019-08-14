Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A75FE8DD22
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2019 20:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfHNSkX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Aug 2019 14:40:23 -0400
Received: from resqmta-po-10v.sys.comcast.net ([96.114.154.169]:60164 "EHLO
        resqmta-po-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728265AbfHNSkX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Aug 2019 14:40:23 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Aug 2019 14:40:23 EDT
Received: from resomta-po-13v.sys.comcast.net ([96.114.154.237])
        by resqmta-po-10v.sys.comcast.net with ESMTP
        id xvs0hY59jELdDxy4FhLW67; Wed, 14 Aug 2019 18:32:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1565807535;
        bh=dwjFedyl7PFAsVX36yTCWtHF0uR7vwswCWP6t2DPWIQ=;
        h=Received:Received:Received:Received:Date:From:To:Subject:
         Message-ID:Reply-To:MIME-Version:Content-Type;
        b=nLmZCbS9DiI3ZwzSLk/FepW8U+D9/b/8Zy8SnVHk1tjeccJQRnCloOjlqgs1VXa4t
         RSMPwjR5vL4f7QLPEVAOBrG8/Nsw2xZA2/2n4xGl1gkv+2HCOjcYlhln7GJXC1s9TZ
         Ps85Y8C0Ebdk7qcbNCsm0hRuIfAo0IlJXxeI4VP9vkXjJbL+wURu06LMGQMkHtv5H8
         Z4xEaFyDx/B187ZV+dI7dhVB0tbz9G+wzSW+eu2VPg858n2L+JnD/+MYnSXJmmCG22
         ZCFwP8Nfi1dWbOTriuQ6hF3QmWNADcymlxXafW+kvi9fS+CS3jdsYh0awvgpehLg0+
         T3S12X3LyiiXg==
Received: from beta.localdomain ([73.209.109.78])
        by resomta-po-13v.sys.comcast.net with ESMTPA
        id xy4DhOcvoDWf1xy4Eh2fMO; Wed, 14 Aug 2019 18:32:15 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgeduvddruddvledgieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkrhggtgguvggfsehttdertddtredvnecuhfhrohhmpefvihhmucghrghlsggvrhhguceothifrghlsggvrhhgsegtohhmtggrshhtrdhnvghtqeenucfkphepjeefrddvtdelrddutdelrdejkeenucfrrghrrghmpehhvghlohepsggvthgrrdhlohgtrghlughomhgrihhnpdhinhgvthepjeefrddvtdelrddutdelrdejkedpmhgrihhlfhhrohhmpehtfigrlhgsvghrghestghomhgtrghsthdrnhgvthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-Xfinity-VMeta: sc=0;st=legit
Received: from calvin.localdomain ([10.0.0.8])
        by beta.localdomain with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <twalberg@comcast.net>)
        id 1hxy4D-0006OD-AY; Wed, 14 Aug 2019 13:32:13 -0500
Received: from tew by calvin.localdomain with local (Exim 4.84_2)
        (envelope-from <tew@calvin.localdomain>)
        id 1hxy4D-0003AC-4B; Wed, 14 Aug 2019 13:32:13 -0500
Date:   Wed, 14 Aug 2019 13:32:13 -0500
From:   Tim Walberg <twalberg@comcast.net>
To:     linux-btrfs@vger.kernel.org
Subject: recovering from "parent transid verify failed"
Message-ID: <20190814183213.GA2731@comcast.net>
Reply-To: Tim Walberg <twalberg@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Most of the recommendations I've found online deal with when "wanted" is
greater than "found", which, if I understand correctly means that one or
more transactions were interrupted/lost before fully committed.

Are the recommendations for recovery the same if the system is reporting a
"wanted" that is less than "found"?

-- 
twalberg@comcast.net
