Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3541F217F7A
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 08:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgGHGRr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 02:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHGRr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 02:17:47 -0400
Received: from poltsi.fi (unknown [IPv6:2a02:c207:2033:3479::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1027BC061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 23:17:47 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by poltsi.fi (Postfix) with ESMTP id 7189A6E05A3
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 09:17:45 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 poltsi.fi 7189A6E05A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=poltsi.fi; s=default;
        t=1594189065; bh=2hU+QlCWgPPEojjRnqExvtq5TvPRxX/ScSyF0LIyiGM=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=UGvwgCH8s19tE7eDZqzq4wDm17QHXHtaYV3LtfIAiw5ArDNh3Yh2RRgmtnxNTTlv0
         zgVPMtieNLno1m3v1O4qM7kyNml/2CFGpjGcT5KA1on1hY3bXvltVkkBF/NVg5cNsw
         bFlu3qJFpYuRnsM/f+cP2ecTB4h4cE8S+cmnbBEA=
X-Virus-Scanned: amavisd-new at poltsi.fi
Received: from poltsi.fi ([127.0.0.1])
        by localhost (poltsi.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Y5RXchEAnqDY for <linux-btrfs@vger.kernel.org>;
        Wed,  8 Jul 2020 09:17:43 +0300 (EEST)
Received: from webmail.poltsi.fi (localhost.localdomain [127.0.0.1])
        by poltsi.fi (Postfix) with ESMTP id A94916E0578
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 09:17:43 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 poltsi.fi A94916E0578
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=poltsi.fi; s=default;
        t=1594189063; bh=2hU+QlCWgPPEojjRnqExvtq5TvPRxX/ScSyF0LIyiGM=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=czMmlVsCQoC88RVNXanP3f6sf3zDTQ6OC4jmBqWCVwz5kjaEk52zMEpZECC9htQxv
         esYcLMXiKnHPd/6YR0KY8dzoNyTff3X03nYlhkD3x56euAdvz0l/0U9fadUpqmL7vM
         7A0AYj6mSLvRPpt0cPzkVsyG3j2Sr2/8dICUedEM=
MIME-Version: 1.0
Date:   Wed, 08 Jul 2020 09:17:43 +0300
From:   =?UTF-8?Q?Paul-Erik_T=C3=B6rr=C3=B6nen?= <poltsi@poltsi.fi>
To:     linux-btrfs@vger.kernel.org
Subject: Re: BTRFS-errors on a 20TB filesystem
In-Reply-To: <5ab5584d-abc9-2137-a8ec-1429dbe3b075@gmx.com>
References: <0bd8aea3d385aa082436775196127f1f@poltsi.fi>
 <f2d396d4-8625-1913-9b1c-2fec1452defa@gmx.com>
 <9a804cbb7406be31f55c68d592fd0bd6@poltsi.fi>
 <960db29cd8aa77fd5b8da998b8f1215b@poltsi.fi>
 <e1beb547-3989-0fdd-b2e4-5491728f7dec@gmx.com>
 <7bfbcd06-f4f8-5946-c5e4-d7c7879cf122@poltsi.fi>
 <446cbb5e-bb18-bb93-ee98-d480730e4508@gmx.com>
 <974197e0-0dc3-e0c4-6c44-b5fe8b6c6f6d@poltsi.fi>
 <5ab5584d-abc9-2137-a8ec-1429dbe3b075@gmx.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <321bb5fade357f832c1a7f89c566a7c3@poltsi.fi>
X-Sender: poltsi@poltsi.fi
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-07-08 02:43, Qu Wenruo wrote:
> Thank you very much for all these detailed info!

No problem.

Is there anything else you need?

As I mentioned previously, I got backup of all data (which is not 
already lost), so I can run some destructive commands too on the 
partition if it helps.

Poltsi
