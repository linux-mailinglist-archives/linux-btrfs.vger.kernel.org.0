Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BF46F0F61
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 02:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbjD1ANF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 20:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD1AND (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 20:13:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD4F2706
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 17:13:02 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCKFu-1q0TCj0lco-009Mr1; Fri, 28
 Apr 2023 02:12:59 +0200
Message-ID: <f982de87-0e4b-a07e-cb3e-1bea05250b0c@gmx.com>
Date:   Fri, 28 Apr 2023 08:12:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] btrfs: properly reject clear_cache and v1 cache for
 block-group-tree
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>, dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <832315ce8d970a393a2948e4cc21690a1d9e1cac.1682559926.git.wqu@suse.com>
 <20230427233229.GK19619@twin.jikos.cz>
 <de1a63db-2f30-5969-bc28-a53faaed1608@gmx.com>
 <b7827fcee415d416d3a7a07bac0964cdf4fd003d.camel@scientia.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <b7827fcee415d416d3a7a07bac0964cdf4fd003d.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ruZRG7X68trihle917HF49BeRjRGdwItoL1oGaV99c+4lrWwZbn
 ZL6DOoXFhB8PGsw6UEUnDYUp7+DRSuOkiOTQoaFnJIlF3lEi57Je37j1ZbQWgZqcTljWdpi
 LB0KuWyV/CjlcU/CJ1NM3ZpU7clv11nDYIDmhk+HjYWOI8pkhirsBFTmWIQY2k9jmiOgCYr
 2sVWT+fDghF9Ir+EW5rRw==
UI-OutboundReport: notjunk:1;M01:P0:Gb8eoCZoLfw=;9MrgTb7Q8IbmJNrPr49KQKBKymm
 v8BcVSRX1+TfUH1fcnqzae8ml6F4WCftFp8F6yZfkuoLQ5ojeQv/wvP90itEjH1HHWK1NAfJB
 b4Xm4LjykjIXja0N1fsBGeFORGJk18Xl8iXAfzJv5UToP+il3Q6l7Ta4/1EGLvcmgIyffsVGD
 5se2QYsynC3u6ju6Qgnyv9uum2RIZ9Q1PPexDs4pz+MqfCbyJTjHq+OEFazE2aT3DfZx5m63Y
 Xv7p9yDcJ5HX8fdz7zagubzMOBwr83jvCkPP/Iuiop24h+RAPLvprRi7/kNXKhgFX8Ar/T5k+
 tlORnCDY1qzoDFD6fZ4WIfXbpru6lcG2MeNPVrOJaeMf/m7ylAAHkSX61DxEWdwblQIzSPbxe
 5HdH/PjO6mZ4vsoycmR+WW+Ki/38d0/edjTeFc50lEZbXXUvZmM5zoC+W0PuPEDJ0jIsJmn4x
 TvXT54lN41O6xjsANMhgwqFK2ZWA1Ba+qyjdadRwzJtD5uln6DbaGrJQhJ94MmSjXiX3fIiBH
 EtsaPqWaWI1XhdjMrawdEDg5MfRbFEjwJt3ibSdwzb1xb8COD4uT9fM5MBBlg07VttelUrthi
 wLn3kcHKmI3mSEZ/RPRg3anQ2GdD5GmkShIjQDsYRbE5figyFeYPZQdEUcBqgWXc9NEAh4jyC
 L0XDXH6ePqw9mfocjsIz9gfPhdnD7ff5ZdIVngRGZJP71kZFj6xlHdOT7gbCvLmJIO9B4h/Wz
 A7xdFmPUaaGGs2cgpG2j1bUWk+BhsKkWQ1MvbylC/D09g59++ro7Pw/8AmyWQFSBic2RTFbqA
 QIXl559A4JiMOL8aQmJgMTArxX1zQQrg4UdnW2zhPpa5AW1wp/ipj+gy7wzIGFk6bxKJgZi4r
 cyFpIjDs3grot2c4QI2VvleaNSxJplUOpWoYUiqcMqJAEozltdiNAx26xqhg8Rdey3yDnnRwO
 6JFIIcijS+bcfVRoPG/bvendmXU=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/28 07:41, Christoph Anton Mitterer wrote:
> On Fri, 2023-04-28 at 07:37 +0800, Qu Wenruo wrote:
>> On the clear cache behavior, I'm working on making it independent
>> from
>> the current cache version.
>> E.g. on v2 cache, clear_cache would just clear the cache, without
>> (temporarily) falling back to v1.
> 
> If you make any such changes, please be sure to also adapt the docs...
> or tell me how it (then) works and I may help you out with some doc
> PRs.

I'm not yet determined what's the proper way to go.

If I can finish the clear_cache behavior in small enough patches and 
backport for v6.1+, I believe there would be no extra docs needed, 
except mentioning bgt needs no-holes and free-space-tree.

Every unsupported combination would got proper dmesg prompt.

Thanks,
Qu

> 
> Cheers,
> Chris.
