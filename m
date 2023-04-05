Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327516D8AEE
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 01:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjDEXHR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 19:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDEXHP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 19:07:15 -0400
Received: from se1.syd.hostingplatform.net.au (se1.syd.hostingplatform.net.au [IPv6:2400:b800:3:1::220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA546196
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 16:07:13 -0700 (PDT)
Received: from s02bd.syd2.hostingplatform.net.au ([103.27.32.42])
        by se1.syd.hostingplatform.net.au with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <linuxkernel@edcint.co.nz>)
        id 1pkCDc-0005tD-92
        for linux-btrfs@vger.kernel.org; Thu, 06 Apr 2023 09:07:11 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:From:To:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Subject:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=; b=xS0oMPpm1qLVwciKukPouErPgb
        7cPsTsm7/E/YZvElsbdYzeK4kTH26PQXZA9RGukPJq/UC+cp2slnM6P2Pfk/hkbP1GIC8CsXYTv+H
        NlLGSRVtfhIyjCC7mpqf6nhYAdAx7ZGMUwz30jCOg+IdaM5kL1tlUEiCzONgULbbklXQPxPOa7edU
        bUCqRcaxlFKiqzY4oURUdmj+sXaKds/1P3q/pNR34jYTf7CFl2MvfSgftOl2x0KLzGuNfhAkyGm1n
        8a9kOLtGFXLzkqUf+onsnQdbIecSWrpKOAyTuuwGEqXtX0lCpZT1KfxkIrNDAFab8hVfBY6gatBiJ
        O3nObkHA==;
Received: from [159.196.20.165] (port=36882 helo=[192.168.2.80])
        by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <linuxkernel@edcint.co.nz>)
        id 1pkCDb-002Ujq-20
        for linux-btrfs@vger.kernel.org;
        Thu, 06 Apr 2023 09:07:07 +1000
Message-ID: <167bca3c-e1db-40f2-01a3-4ea996663cd2@edcint.co.nz>
Date:   Thu, 6 Apr 2023 09:07:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
From:   Matthew Jurgens <linuxkernel@edcint.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s02bd.syd2.hostingplatform.net.au
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - edcint.co.nz
X-Get-Message-Sender-Via: s02bd.syd2.hostingplatform.net.au: authenticated_id: default@edcint.co.nz
X-Authenticated-Sender: s02bd.syd2.hostingplatform.net.au: default@edcint.co.nz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Originating-IP: 103.27.32.42
X-SpamExperts-Domain: out-2.hostyourservices.net
X-SpamExperts-Username: 103.27.32.42
Authentication-Results: syd.hostingplatform.net.au; auth=pass smtp.auth=103.27.32.42@out-2.hostyourservices.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.15)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9WLQux0N3HQm8ltz8rnu+BPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5ztW2DfCmdqRCMoho/8w6SaWy8Zi3U/W0AnUgWIBqewEKvp
 k7Vp2UXVHEQMIct0liIRuZtIOLkEKhfB0zGPPXK+swKQDamPN66SYe4XX4xmgLCYsio9CJXI1dEg
 ssO98q8hUArge52zFlDybzC33IYWpuGXed8VjoeeEKguXydrkTGNg+WW4Te4WbcL+p/1yxbQmiJo
 jrfzAYCmmhKpeMYWo9es9YxaA7VQEe8mHeTGyP5h9t+Rsczj3XfeY2wzO8rM7XUFEqpPwHi4uufu
 LPy68sEzNshBxIbwvSM7MvzRDUzENyoN4S9qF8+QOROUf3UuBpCeYXwfqlroHwxMrWWKAAn0bQYy
 8xI4CGTS1oSPzJkRDwCGfz1JXQHWqw9OMCYI1buGfzBzbPwORezig0Kivdn+kS0d+AZnld5hVrcw
 Vp1IIYAHBv0PxorZCJ/m663fX8TdqEXkwxwMjsp2mNApUS4dy85LXE4+MyS1T67kaEroB7jD3z/T
 bTsZKb9DN2x3/yDymHmmZjcFbGH6DDT5s253c+DMoZnzyKh2h2r9h9VYyUehaHtgnvRgGTw3nLHo
 nV+E7OMXRvgtdyMlnmWiZJ54J+zOAJFvZX6oW/hCc9/hol6eJGzLavdADnIblUu2vw36PZ3TOZat
 BN874FX83SOa86FBbCU/JTCUgCnq6Kocg0Ly4OEvdmwaeApmYxQs6Os7DAYjeQq7TkmcOW/upw4+
 YWF4YjAVAXAY6UHEB2LIlrbGlRcl6evmXRPDgLA0pBShsjuG4FWhl4kkoP5YpASU8nI0l2AWwkUS
 z/3cxVpJTakgG8VY5R0Lvz/UYfPkCcj7ATESLZldlzAWaP8bOohEXtLHlwjXSlX+qiuYLAdWZFYh
 Tgy4shDDliHJSwH4HRi6c6DUAuarAa8UYGi4pNF1tS0PcYyvSSn8OVG1NbA+BsIrAO5wNoMhbD4a
 lvM1Q2yTITNEqokCKaRTOpRi9rDLnk92eVD13l7ydBE/r0roB7jD3z/TbTsZKb9DN2wSnRK0AhTm
 icxbnZ6m23vwmtPyZBoAbSgMSDXeEWfo5/SShkQaRNaGrPnNqk01Gtv2OKHH5lr9xXvSM4nM3avg
X-Report-Abuse-To: spam@se.syd.hostingplatform.net.au
X-Spam-Status: No, score=1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,MISSING_SUBJECT,SPF_HELO_NONE,SPF_PASS,
        TVD_SPACE_RATIO autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

unsubscribe

