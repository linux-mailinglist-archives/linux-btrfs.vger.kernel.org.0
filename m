Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1948267B84
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Sep 2020 19:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgILRN0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Sep 2020 13:13:26 -0400
Received: from mailrelay4-3.pub.mailoutpod1-cph3.one.com ([46.30.212.13]:14873
        "EHLO mailrelay4-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbgILRNY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Sep 2020 13:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:date:message-id:subject:
         from:to:from;
        bh=e7VPF07MEjc0QYoM/lBur52doXsYNVHK7eNG0Otw9V8=;
        b=d7+FXuqyj7zFfm+UnMHg/+XSAmz+BVQITdBi0KrF3scq5AqM4/a/D+dLh/jCEYJhVCa4qX3ESBNDY
         6UThoPnNYeD8ANtoUk8EoehasYl2dxXJahj2BNoNk/svWSRlkzFr1SO1QzoYNgccJyJM3uhoqnnFr8
         EM7L+F7hGJp4H7l03u6QzpA5xhtZm3AaorLG1aaX+HhIg39LlzFiur7LjGhMzY1dUDgHJP439gt8SU
         XKKAs3oU4bkTt88ZBVuSbTahwVAoFpbNH/mwJRp/gKQWZC/dfgRfgyUfQP7T4lgtG0A1YyidSFY7AY
         3ZcUy4lRnrYGW7dIg0vlr+oYAOTu3hA==
X-HalOne-Cookie: b41491b0c2a81ddbb30cd9cda7d8e5c095b3bf38
X-HalOne-ID: 428a292f-f51b-11ea-a2a9-d0431ea8bb10
Received: from [192.168.0.10] (h-131-138.a357.priv.bahnhof.se [81.170.131.138])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 428a292f-f51b-11ea-a2a9-d0431ea8bb10;
        Sat, 12 Sep 2020 17:13:22 +0000 (UTC)
To:     linux-btrfs@vger.kernel.org
From:   A L <mail@lechevalier.se>
Subject: Changes in 5.8.x cause compsize/bees failure
Message-ID: <632b888d-a3c3-b085-cdf5-f9bb61017d92@lechevalier.se>
Date:   Sat, 12 Sep 2020 19:13:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I noticed that in (at least 5.8.6 and 5.8.8) there is some change in 
Btrfs kernel code that cause them to fail.

For example compsize now often/usually fails with: "Regular extent's 
header not 53 bytes (0) long?!?"

Bees is having plenty of errors too, and does not succeed to read any 
files (hash db is always empty). Perhaps this is an unrelated problem?


