Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054201E69A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 20:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391489AbgE1SnO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 14:43:14 -0400
Received: from smtp-35-i2.italiaonline.it ([213.209.12.35]:59032 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387957AbgE1SnN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 14:43:13 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2020 14:43:12 EDT
Received: from venice.bhome ([78.12.136.199])
        by smtp-35.iol.local with ESMTPA
        id eNMpjt6z1LNQWeNMqjtDfS; Thu, 28 May 2020 20:35:00 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590690900; bh=noAwzcPQ+LvYU4yAYTCyOY4PPHoDTXAQOrs9V9ZnZ5E=;
        h=From;
        b=SEUIZGQWf86L+6R/BKqwLARj030NLkdGIyA50d9VnSeKTgtw6Gcilcmn+iNeDE2K4
         CCu76Dsm5cQZoICPRM8WuNTon8pj5phMR2Jb5S1UFipRJWu/AmA3bceCWaxc+3NqES
         5PA7lx13P/0tVx/HkDCtvnZp/sNUu7JlyYvnXfdEf77IRUUfjUqKbuYhbYgX4HHd95
         Fb/mpaNMwJI2IMyue3xip7Sr8wAgJQV0YO/lbaVayMJn3BpAbSdRlrB+brMKMhDXVS
         9W3bx7FQz80V970dFb+3oSbCv1yRzmqIZYEJSC1rEaDcCp4IfJGI0n0HGMe1slefuc
         VeCItxj4n6WUg==
X-CNFS-Analysis: v=2.3 cv=LKsYv6e9 c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=kwJbIOCL_PGvz6YFjioA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC][PATCH V4] btrfs-progs: preferred_metadata: preferred device for metadata
Date:   Thu, 28 May 2020 20:34:53 +0200
Message-Id: <20200528183456.18030-1-kreijack@libero.it>
X-Mailer: git-send-email 2.27.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLMktXZF/NLz8gW5JWErp17mvovLSk3VXUW20thWXTr8hbT3unapcCAqjKxNdJdNwAd8tMv4+ohQzRZLbu+2QPw2PdfPhyaZShww1V9z/wKAKOF51aTC
 tYvZXiM25snZBJOYh+4ddTKC029/0uh0VbG7AFsDEnsqjee4Z2tvzAoHK4X1dlWN5q3vwcjJeo55Aw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this is the user space part of the patches set "[RFC][PATCH V4] btrfs:
preferred_metadata: preferred device for metadata".
Refer to this patches set for the info.

This patch set implements the "btrfs property get/set preferred_metadata".

The first patch adds the ioctl support.
The second patch adds the property handler.
The third patch adds an update of the man page.

BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B


