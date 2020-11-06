Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700B92A96EE
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 14:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgKFNXa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 08:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbgKFNX3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 08:23:29 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A4FC0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 05:23:29 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id c17so1298793wrc.11
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 05:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N6V+b66InQZeO6NMcumH2sM4beYJa7BC0WQJ6Ik2WZw=;
        b=bgKKHMlKIy65BW6daY0/x2ZX5WW60TWbizrLTWNKG5GOO65xybsM8BVSbL62unkw6D
         vLtb7Wt+UhT18k5TwBUNdtME367wfQLMRqnHIjrDM2ouazmaxxUbKw8c1evBVtwTQy0G
         TdHY16ChKnBAHeDydaG7BXnyGe/B7AYzeSTnLKtS1M9pQQHps1HzIhVWN6O9ZpsqplR9
         GLjMxT8QLZsfpASEO5W/P91JvL8t9bMY4be0xH4TWHX0RXW+CibtGf21RiGd0ywuyQee
         O9Vq6mMqLpDLrzSgovddMaiYHiVcOFUPDdqBoNDuaymN+bGlPNl4FJyVFBBFNwl1et/k
         ar3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N6V+b66InQZeO6NMcumH2sM4beYJa7BC0WQJ6Ik2WZw=;
        b=dU4PjB4avhT8zpoFXkjND5h2ciYaOrt4pVBf348XaWG+UB2IFXYyARvDblZneRJMCe
         NlfFYmeqjK3ZRJH3nMHDGOr7QnRRRFuxfwmibbUJE/UW/OWXD9W5jqXxOuoQg7Ee9DSY
         vY8tarf8UdT5OwJj1YtBZn64OOCPeDdRLJIgZnv6KLd2KieGkLVnGOo1jTp4fcSqUJn4
         Y2fnm8xUHEO7MnTQ3J3RuH7T8b/JkCdzEH0FAn8IRCLfOpnZg4swOhsZjy4SUtg+2XFq
         5nlszSCLbAQKC95WFb08pPfHhEa6CgPR9LWKmelM7AtkYlPJkaN9CkEgDVGXhZWVmrGH
         2knQ==
X-Gm-Message-State: AOAM533BI/V8biiJoesmW1rfP10z5uWpepWDNLW7HmMDSAbjhjjb0OHN
        r8kt0O/HsXy1Fxo7yJzL2zw/qwC/Y4Y=
X-Google-Smtp-Source: ABdhPJwoTY3CI4B9LDkpy6R23x5NtJmsaL1L3vGOzbk/HJsa3UjhYqH/ghTewm6RI6WfquRuqOPSIg==
X-Received: by 2002:adf:fd06:: with SMTP id e6mr2722325wrr.206.1604669007860;
        Fri, 06 Nov 2020 05:23:27 -0800 (PST)
Received: from [192.168.1.139] (host109-152-100-228.range109-152.btcentralplus.com. [109.152.100.228])
        by smtp.gmail.com with ESMTPSA id n8sm2177708wmc.11.2020.11.06.05.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 05:23:27 -0800 (PST)
To:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1604444952.git.asml.silence@gmail.com>
 <20201105222305.GN6756@twin.jikos.cz>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFmKBOQBEAC76ZFxLAKpDw0bKQ8CEiYJRGn8MHTUhURL02/7n1t0HkKQx2K1fCXClbps
 bdwSHrhOWdW61pmfMbDYbTj6ZvGRvhoLWfGkzujB2wjNcbNTXIoOzJEGISHaPf6E2IQx1ik9
 6uqVkK1OMb7qRvKH0i7HYP4WJzYbEWVyLiAxUj611mC9tgd73oqZ2pLYzGTqF2j6a/obaqha
 +hXuWTvpDQXqcOZJXIW43atprH03G1tQs7VwR21Q1eq6Yvy2ESLdc38EqCszBfQRMmKy+cfp
 W3U9Mb1w0L680pXrONcnlDBCN7/sghGeMHjGKfNANjPc+0hzz3rApPxpoE7HC1uRiwC4et83
 CKnncH1l7zgeBT9Oa3qEiBlaa1ZCBqrA4dY+z5fWJYjMpwI1SNp37RtF8fKXbKQg+JuUjAa9
 Y6oXeyEvDHMyJYMcinl6xCqCBAXPHnHmawkMMgjr3BBRzODmMr+CPVvnYe7BFYfoajzqzq+h
 EyXSl3aBf0IDPTqSUrhbmjj5OEOYgRW5p+mdYtY1cXeK8copmd+fd/eTkghok5li58AojCba
 jRjp7zVOLOjDlpxxiKhuFmpV4yWNh5JJaTbwCRSd04sCcDNlJj+TehTr+o1QiORzc2t+N5iJ
 NbILft19Izdn8U39T5oWiynqa1qCLgbuFtnYx1HlUq/HvAm+kwARAQABtDFQYXZlbCBCZWd1
 bmtvdiAoc2lsZW5jZSkgPGFzbWwuc2lsZW5jZUBnbWFpbC5jb20+iQJOBBMBCAA4FiEE+6Ju
 PTjTbx479o3OWt5b1Glr+6UFAlmKBOQCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQ
 Wt5b1Glr+6WxZA//QueaKHzgdnOikJ7NA/Vq8FmhRlwgtP0+E+w93kL+ZGLzS/cUCIjn2f4Q
 Mcutj2Neg0CcYPX3b2nJiKr5Vn0rjJ/suiaOa1h1KzyNTOmxnsqE5fmxOf6C6x+NKE18I5Jy
 xzLQoktbdDVA7JfB1itt6iWSNoOTVcvFyvfe5ggy6FSCcP+m1RlR58XxVLH+qlAvxxOeEr/e
 aQfUzrs7gqdSd9zQGEZo0jtuBiB7k98t9y0oC9Jz0PJdvaj1NZUgtXG9pEtww3LdeXP/TkFl
 HBSxVflzeoFaj4UAuy8+uve7ya/ECNCc8kk0VYaEjoVrzJcYdKP583iRhOLlZA6HEmn/+Gh9
 4orG67HNiJlbFiW3whxGizWsrtFNLsSP1YrEReYk9j1SoUHHzsu+ZtNfKuHIhK0sU07G1OPN
 2rDLlzUWR9Jc22INAkhVHOogOcc5ajMGhgWcBJMLCoi219HlX69LIDu3Y34uIg9QPZIC2jwr
 24W0kxmK6avJr7+n4o8m6sOJvhlumSp5TSNhRiKvAHB1I2JB8Q1yZCIPzx+w1ALxuoWiCdwV
 M/azguU42R17IuBzK0S3hPjXpEi2sK/k4pEPnHVUv9Cu09HCNnd6BRfFGjo8M9kZvw360gC1
 reeMdqGjwQ68o9x0R7NBRrtUOh48TDLXCANAg97wjPoy37dQE7e5Ag0EWYoE5AEQAMWS+aBV
 IJtCjwtfCOV98NamFpDEjBMrCAfLm7wZlmXy5I6o7nzzCxEw06P2rhzp1hIqkaab1kHySU7g
 dkpjmQ7Jjlrf6KdMP87mC/Hx4+zgVCkTQCKkIxNE76Ff3O9uTvkWCspSh9J0qPYyCaVta2D1
 Sq5HZ8WFcap71iVO1f2/FEHKJNz/YTSOS/W7dxJdXl2eoj3gYX2UZNfoaVv8OXKaWslZlgqN
 jSg9wsTv1K73AnQKt4fFhscN9YFxhtgD/SQuOldE5Ws4UlJoaFX/yCoJL3ky2kC0WFngzwRF
 Yo6u/KON/o28yyP+alYRMBrN0Dm60FuVSIFafSqXoJTIjSZ6olbEoT0u17Rag8BxnxryMrgR
 dkccq272MaSS0eOC9K2rtvxzddohRFPcy/8bkX+t2iukTDz75KSTKO+chce62Xxdg62dpkZX
 xK+HeDCZ7gRNZvAbDETr6XI63hPKi891GeZqvqQVYR8e+V2725w+H1iv3THiB1tx4L2bXZDI
 DtMKQ5D2RvCHNdPNcZeldEoJwKoA60yg6tuUquvsLvfCwtrmVI2rL2djYxRfGNmFMrUDN1Xq
 F3xozA91q3iZd9OYi9G+M/OA01husBdcIzj1hu0aL+MGg4Gqk6XwjoSxVd4YT41kTU7Kk+/I
 5/Nf+i88ULt6HanBYcY/+Daeo/XFABEBAAGJAjYEGAEIACAWIQT7om49ONNvHjv2jc5a3lvU
 aWv7pQUCWYoE5AIbDAAKCRBa3lvUaWv7pfmcEACKTRQ28b1y5ztKuLdLr79+T+LwZKHjX++P
 4wKjEOECCcB6KCv3hP+J2GCXDOPZvdg/ZYZafqP68Yy8AZqkfa4qPYHmIdpODtRzZSL48kM8
 LRzV8Rl7J3ItvzdBRxf4T/Zseu5U6ELiQdCUkPGsJcPIJkgPjO2ROG/ZtYa9DvnShNWPlp+R
 uPwPccEQPWO/NP4fJl2zwC6byjljZhW5kxYswGMLBwb5cDUZAisIukyAa8Xshdan6C2RZcNs
 rB3L7vsg/R8UCehxOH0C+NypG2GqjVejNZsc7bgV49EOVltS+GmGyY+moIzxsuLmT93rqyII
 5rSbbcTLe6KBYcs24XEoo49Zm9oDA3jYvNpeYD8rDcnNbuZh9kTgBwFN41JHOPv0W2FEEWqe
 JsCwQdcOQ56rtezdCJUYmRAt3BsfjN3Jn3N6rpodi4Dkdli8HylM5iq4ooeb5VkQ7UZxbCWt
 UVMKkOCdFhutRmYp0mbv2e87IK4erwNHQRkHUkzbsuym8RVpAZbLzLPIYK/J3RTErL6Z99N2
 m3J6pjwSJY/zNwuFPs9zGEnRO4g0BUbwGdbuvDzaq6/3OJLKohr5eLXNU3JkT+3HezydWm3W
 OPhauth7W0db74Qd49HXK0xe/aPrK+Cp+kU1HRactyNtF8jZQbhMCC8vMGukZtWaAwpjWiiH bA==
Subject: Re: [PATCH 0/4] fixes for btrfs async discards
Message-ID: <215f6406-fbe2-9eb6-2ac2-7f28b2666789@gmail.com>
Date:   Fri, 6 Nov 2020 13:20:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201105222305.GN6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/11/2020 22:23, David Sterba wrote:
> On Wed, Nov 04, 2020 at 09:45:50AM +0000, Pavel Begunkov wrote:
>> Several fixes for async discards. The first patch might increase discard
>> rate, drastically in some cases. That may be a suprise for those
>> assuming that hitting iops_limit is rare and rarther outliers. Though,
>> it still stays in allowed range, so should be fine.
> 
> I think this highly depends on the workload, if you really need to issue
> the discards fast because of the rate of the change in the regular data.
> That was the point of the async discard and the knobs, the defaults
> should be ok for most users and allow adjusting for specific loads.

Chris mentioned that _there are_ problems with faster drives though.
The problem is that this iops_limit knot just clamps the chosen delay.
Ultimately, I want to find later a better delay function than

delay = CONSTANT_INTERVAL_MS / nr_extents.

But that will take some thinking.

For instance, one of the cases I've seen is recycling large extents
like deletion of subvolumes. There we have a small number of extents
but each takes a lot of space, so there are, say, 100+GB queued to be
discarded. But because there are few extents, delay is calculated
to >10s that's then clamped to a constant max limit.
That was taking a long to recycle. Not sure though how many bytes/extents
are discarded on each iteration of btrfs_discard_workfn().

> 
> My testing of the original discard patchset was tailored towards the
> default usecase and likely intense than yours. I did not observe the
> corner cases where the work queue scheduling was off, or changing the
> sysfs values did not poke the right kthreads.
> 
> Patches look ok to me and I've added them to topic branch for testing,
> going to misc-next later. Thanks.
> 

-- 
Pavel Begunkov
