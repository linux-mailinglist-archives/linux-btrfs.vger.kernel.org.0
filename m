Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3252509355
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 01:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383068AbiDTXHl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 19:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383082AbiDTXHa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 19:07:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4A926558
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 16:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650495869;
        bh=6d06UzZPGk0Pr1+sqq+4nVPkw2Cr3FzboPJgb/oS8y0=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=UuoR9rBfvDb0bcBGl/ETALQn7mQ1YYSh6EwJnbPMNRulz8PrX/gxTpNYWNp27lFhw
         WP7VnpKOfJ97wo7XYRt9MwEnMQNcgtrb9epfaBz0KEtXj4mVZHnGbWXvGB9xPfH1it
         mM9jyPKJ9jPIhbqt7tWbPob9eqb6xy1yQwXyH7Dw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MO9zH-1nWe6X2Z3Z-00OYi9; Thu, 21
 Apr 2022 01:04:29 +0200
Message-ID: <dd842aee-c0be-9c10-f613-1a24d999c513@gmx.com>
Date:   Thu, 21 Apr 2022 07:04:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 00/18] btrfs: split bio at btrfs_map_bio() time
Content-Language: en-US
To:     dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1647248613.git.wqu@suse.com>
 <Yjnu7yWxAforTGQF@infradead.org>
 <96e622b1-fffb-34ae-6055-49bd7a4ea23b@gmx.com>
 <20220420201158.GJ1513@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220420201158.GJ1513@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ixgNsRVrjFDaNU29lmCIaRacUXFlHH6PMepcTXm9HCgvwWVw2Iz
 v7Qe3Law73apH/nF8nHSQfbROT4K1lXxB6cEQOAIy+Ws6Bo7yhfVaT4DAqfF8zH2JERLkpr
 F64f5b9ZHMmY1QeZbNUnwDRFZw2/eajDbQ+nFVCq+yQz8LnhAJmAiLICGs87nxlyT6LQg3X
 n+bybNaxZmnMMWoDA08MA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pXFCwNL6iI8=:SJgDasfczAUmDLcrsQ2Jqo
 uAlZY6yW3531oCywINJrsNa6eb7sLdPdmUZzks2LHmFWqv0u0OfjTXi6p5KzNG52uzCrD2krt
 0SHjjXG1Yd6t6NGKdsbqBlIsy9DbLQuFrruLVaEMoKvWgvhRNGBPBfJC/44sT5nyjwFOUubVw
 yPUvGt/lmHn8fYqH0hfIVCavNsVlUi6Cp146sTerfGsGv4c0ZcOZPXJDsZqHabDJpK0dJkMcl
 Hw+Z9oiwtJELpRUrKChGuf63HGWQfx/GqpFD27/xtAwrfiq2k5P0WRDN11uUD8jxfVCwDT+RA
 sdshx0+JcJz5RnL45vZKGLqdSWwORkfGvFNzC4ZAr9FcgFCUsnecEuc7lMxOLaIw9kPrgZtjN
 0FYm3Yvp4sqbJewnJB7yOBNZyiw7Ud0t/rePJSVjE23PypdEK8OLMe5AGz3q9Rd/vaYK0ouas
 L336jBB7LHorZhcA5hESC2oZbwJcQA9nreoLYb8dgssn41RzpkBI2NHfYqn6YdSjlnk2rNQPm
 1It54MQhNCg0Qa+xIetyptqu1u4QJuILJjolma0+UKPK4eDGmhEU8Qh0dD/I+Vup9aQkj+iF8
 HPFLp9ouk+bHWmZmNA2KAjA5ePJPTynPHu187uVYBps65jMnhalMMBAee4bOaspem9yCWQ/tG
 yl1xLWoGh9TES1qKI+3XwgskYAP3CFukkuplBUfnCgX9tIiJFPxcUwngwMMGWPXwrNUWkW0U1
 E9fElfU+dfo5FlpgMLl8bgbURY4Xu8/wML6Y8WMr8H+v5BJE9aEf2nSRuKW38YWDzPTa0rmwc
 EVvJEy35LirBXHjibcM3p8xzYfLfXrNubyR52hwxJCEmMONjou2oSx00baSqn1xJJViHLqUIS
 raAXuK/5/iLV0t6KajC3Ssa7ya5lgbBuKkrylQzoVyKVYLfwUv0ZzUhOJkRi+wnQhaBYqIQWX
 IbG16UV2sjgZCbsvkdehdxzk5yGTBoQp4Q+iQCTJEWgpWZOr4A0UY1gfiv4sT9dGOqqqCOB6V
 BFxIShFqU2bZr4syMrM6lMiBwI9uvug/ZL5qDjmqGTvU1oIFYp920SpA75GmM5LOsG6iYb2eY
 2ZP8EaSNPhH6GA=
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/21 04:11, David Sterba wrote:
> On Wed, Mar 23, 2022 at 07:45:31AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/3/22 23:44, Christoph Hellwig wrote:
>>> I spent some time looking over this series and I think while it has
>>> some nice cleanups, it also goes fundamentally in the wrong direction.
>>
>> Well, at least I got some review, that's always a good news.
>
> So this whole series will be dropped and replaced by Christoph's
> patches, however if there's anything useful left please send it
> separately later on. Thanks.

I'll refresh the patchset, still keep the core idea of splitting bio at
btrfs_map_bio() time, but also take some ideas from Christoph to further
improve the patchset.

Thanks,
Qu
