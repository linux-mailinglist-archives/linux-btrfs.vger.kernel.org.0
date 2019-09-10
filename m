Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9875AF360
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 01:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfIJXc0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 19:32:26 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:45717 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbfIJXcZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 19:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:Reply-to:In-Reply-To:References:
        Subject:Cc:To:From:Message-ID:Date:Sender:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uYrPOl0yUy7Xz0vgaLKNlkTKLHcrBZvAwya2C9Pybhs=; b=UtCxPfP/iCZjcvzIkKClzvlvVq
        8fux0uWHh0WKl/t932wW5xCkuIGTj8WJQt/kfujsMrYMiGaIjRKf3BRU+uETvRmBXdd+f+NrE+ThC
        Fjr8KJSg5KTD+UZIztp1dQIYKyzFByssPXIPmBrossQKR5B5n1WCVY6OEZz+TAaN4ezPDIitrHIvY
        Z1lUF8qi+kOANNqbL0EexxSc+uG4V5yX5KEEp7hy7nmhsFxn6QRzIV+Biy6BOnt2CM58Y+sNFjaR9
        RSzw4KO4hv7jzbJFSje5GKuJ4H7kksNs8i3Y76ItbBwcEvYa9zmWJAc5GWoSGtEv79RZZk7HE+Mdo
        oSMwhywA==;
Received: from [::1] (port=38130 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <webmaster@zedlx.com>)
        id 1i7pcT-003C0V-7b; Tue, 10 Sep 2019 19:32:25 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Tue, 10 Sep 2019 19:32:21 -0400
Date:   Tue, 10 Sep 2019 19:32:21 -0400
Message-ID: <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
From:   webmaster@zedlx.com
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
In-Reply-To: <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
Reply-to: webmaster@zedlx.com
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server53.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - zedlx.com
X-Get-Message-Sender-Via: server53.web-hosting.com: authenticated_id: zedlryqc/from_h
X-Authenticated-Sender: server53.web-hosting.com: webmaster@zedlx.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:


>> Defrag may break up extents. Defrag may fuse extents. But it  
>> shouln't ever unshare extents.

> Actually, spitting or merging extents will unshare them in a large  
> majority of cases.

Ok, this point seems to be repeated over and over without any proof,  
and it is illogical to me.

About merging extents: a defrag should merge extents ONLY when both  
extents are shared by the same files (and when those extents are  
neighbours in both files). In other words, defrag should always merge  
without unsharing. Let's call that operation "fusing extents", so that  
there are no more misunderstandings.

=== I CHALLENGE you and anyone else on this mailing list: ===

  - Show me an exaple where splitting an extent requires unsharing,  
and this split is needed to defrag.

Make it clear, write it yourself, I don't want any machine-made outputs.



