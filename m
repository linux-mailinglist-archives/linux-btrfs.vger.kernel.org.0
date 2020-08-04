Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E1423B68C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Aug 2020 10:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgHDIMy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Aug 2020 04:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgHDIMy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Aug 2020 04:12:54 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAC1C06174A
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Aug 2020 01:12:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d190so1807920wmd.4
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Aug 2020 01:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/RftEstYtGmqN8Rwq458YLed/CyWhxuCvo4h4GpCJ6U=;
        b=p+4fmgRn6X2z+1Rk2gJQ0yHqapKeIdeixElYaZSiKuJ3Dt9/yzh3XMPu1Lz75+AUba
         pyhAYrqEiMJbRaWC46agxzsyW4KfspTfJSQAFQYi//gQ+lPOQBeRNxc+506Jb2vYfg2A
         1nNdqkoQBtU+NJsFVmeFzvE3JXeMoDgcB5Y80yIM0QKCv9bGSq82WKzYAXPWhOpHaubu
         7EnnCtT5qGSv0PevGZ45EsUoBFQ4vZP9VoTLR7XCmpAl5z1VL3/QDB0qnr5+EemrSUuq
         hgORX2G1pRXmoWYP3pQ5SNDfl5I0OrOQASlOeG9l7Rj+i+gEkdgnHt6SGdphRuJy+fMw
         15Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/RftEstYtGmqN8Rwq458YLed/CyWhxuCvo4h4GpCJ6U=;
        b=fWm5YDJuQSUNS+re9N1NvkiW1rs6NImVn6ioGqnUyvvZMkACMpux/4yER/+U96r1bz
         /ruEiwYY177hV6GSOwANLgBW32/AUD8GijmgZStrtpJrtAusJcGHqkPTX8ZlJwCdl6NE
         gJSKXkuzUzXQX5LPmMn5c++bEr83Bst+vxIsKfTK4KiPzEQlUeP5P1/m19zSXmP+vLlv
         EFXLWc6V0oWYi/dJY6BltM3ShXh7fWje4uFWM9iq5fRnaiBCwTOa4vGmWtWBYrvlTg9t
         MKVq8asreZwFXiqeDKa8YxZCTHXeVa3mlHzM7KeiLhQpmpDh5M8c6+oBdy/HT7lGGZe1
         X3LQ==
X-Gm-Message-State: AOAM530l6MQ7N0OdrGi+MNozQJooZYbB9XgbDM5RY0wzsxPGudnIexyl
        moGQlTbCVPVx+Qhm3UjdWshzubOI
X-Google-Smtp-Source: ABdhPJwza0JUdZn9MAr9mH0t3KP/i8rENAgdiKucGb+ln3oL8f9f92VfVU9gxsemuAor51s8kF97kw==
X-Received: by 2002:a1c:a446:: with SMTP id n67mr2831953wme.174.1596528772865;
        Tue, 04 Aug 2020 01:12:52 -0700 (PDT)
Received: from [10.20.1.172] (ivokamhome.ddns.nbis.net. [87.120.136.31])
        by smtp.gmail.com with ESMTPSA id 33sm31240873wri.16.2020.08.04.01.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 01:12:52 -0700 (PDT)
Subject: Re: [PATCH btrfs-progs] Documentation: btrfs-man5: Remove nonexistent
 nousebackuproot option
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200803042944.26465-1-marcos@mpdesouza.com>
From:   Nikolay Borisov <n.borisov.lkml@gmail.com>
Message-ID: <35384dfa-02c3-5f91-2753-2788ebc5b4bc@gmail.com>
Date:   Tue, 4 Aug 2020 11:12:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803042944.26465-1-marcos@mpdesouza.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3.08.20 г. 7:29 ч., Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Since it's inclusion in b3751c131 ("btrfs-progs: docs: update
> btrfs-man5"), this option was never available in kernel, we can only
> enable this option using usebackuproot.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
