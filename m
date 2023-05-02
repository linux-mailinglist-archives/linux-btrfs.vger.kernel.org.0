Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687396F460C
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 16:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjEBOZq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 10:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjEBOZo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 10:25:44 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2779410E7
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 07:25:43 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-74e4f839ae4so171676185a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 02 May 2023 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1683037542; x=1685629542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=39dR4/opLDOkyzl/R13Xozl1AfW4XkQ5A19FjhwIfSU=;
        b=5obc7HZ62OPAXlSIm7ozrv1e5xzIBI58e9DnqaBwV6tNsWIJEtG8u1+9e+58Kh94oi
         JikBh2UU30H18JKMt0MBKtq2BHafkgr3ID5OQsVYFfLfGuooY4YfqRbPZbl0Yzk0XHlz
         bzTxEjhJj/4fBTcS6NRK2Eu3VRcxOvDTj8rQUvvF86t+IJt2jiRdWuwT0xnD3dQiBjvB
         evWlCxBYHkQQOy+JIs1JdwGxXfXn1I7y6KDEdrE3UT+qlZZe8xqrb2KNZQoOFeyFKb2D
         OOqBcu3CsPhfr5JL5aoFPgmIeimlGVv5RFboSqBVxcRScjG8lRHCjnGnCxyVdfHuE47F
         RwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683037542; x=1685629542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39dR4/opLDOkyzl/R13Xozl1AfW4XkQ5A19FjhwIfSU=;
        b=UqrgLUUmg3puG10orzWt9ZtWuA5+Kxa8yBc6q+M12bGOi1GrHGnlyLYGqLuMYwODKn
         dl66qGWf3KJ08oj7/7s+8Zqji8b0T19JHljeN21Hs/c66aYnte1IGvtLu2dHI59GxU9I
         F9yHmOQdSvmOdEiOExP235WOYAmEpKBmmQmHL5ZhJPzFcFzekTqC1B1OBAh/K+yC50rb
         B0ZJPcibJKBHJ+4dZd8SFgUTyrwxvJlzH/J5K7fOOvHRBi35fifUWBA1GByzSP3v2bdg
         669EFdFuXn6nh4xORbq+YBaydVphoP9xNdbWJUnPKNTPC1j4O53MceC0jj3TH7tQ8BpO
         AkaA==
X-Gm-Message-State: AC+VfDwa5QkmjqhQbee8KBo1/gIqWRlmBueVxgfvpEEBXEjjpac7xLfw
        Ta2PRwBmi2x6LHevB2Urag7qag==
X-Google-Smtp-Source: ACHHUZ6OVEIpLcEW4dkWaYXEfwi/T8jNbIop8tJgJxABRpCR9XD+JvBSdd5KbQ0Csi5Fax9lJJVPAw==
X-Received: by 2002:a05:6214:b67:b0:5f1:5f73:aee0 with SMTP id ey7-20020a0562140b6700b005f15f73aee0mr5252581qvb.15.1683037542057;
        Tue, 02 May 2023 07:25:42 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o10-20020a0cecca000000b005f227de6b1bsm9492683qvq.116.2023.05.02.07.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 07:25:41 -0700 (PDT)
Date:   Tue, 2 May 2023 10:25:33 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: enable -Wmissing-prototypes for debug builds
Message-ID: <20230502142533.GA1493492@perftesting>
References: <8cf9b5f14a52067bec9c4bb9f2d2c13821e0d7b6.1682990969.git.wqu@suse.com>
 <20230502114142.GA8111@twin.jikos.cz>
 <f0af43f7-dd50-85aa-ff92-4bcac5d40ce5@suse.com>
 <20230502133045.GD8111@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502133045.GD8111@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 02, 2023 at 03:30:45PM +0200, David Sterba wrote:
> On Tue, May 02, 2023 at 08:00:57PM +0800, Qu Wenruo wrote:
> > 
> > 
> > On 2023/5/2 19:41, David Sterba wrote:
> > > On Tue, May 02, 2023 at 09:29:30AM +0800, Qu Wenruo wrote:
> > >> During development I'm a little surpirsed we don't have
> > >> -Wmissing-prototypes enabled even for debug builds.
> > > 
> > > The build supports W=levels like kernel and -Wmissing-prototypes is in
> > > level 1. In some cases we may want to add the warnings to be on by
> > > default for debugging builds though.
> > 
> > I just did a quick search for the word "missing" of progs Makefile, 
> > unforunately no hit, thus I doubt if it's even in debug level 1.
> > 
> > And the missing prototypes warning is by default enabled for kernel.
> 
> $ grep missing Makefile.extrawarn
> warning-1 += -Wmissing-declarations
> warning-1 += -Wmissing-format-attribute
> warning-1 += $(call cc-option, -Wmissing-prototypes)
> warning-1 += $(call cc-option, -Wmissing-include-dirs)
> warning-1 += $(call cc-disable-warning, missing-field-initializers)
> warning-2 += $(call cc-option, -Wmissing-field-initializers)
> 
> > [...]
> > >>   
> > >> +#include "sha.h"
> > > 
> > > This does not seem necessary, include whole file just for one prototype.
> > 
> > This is necessary as we would define a global function, without 
> > including the header we got the missing prototype warning.
> > 
> > All the other comments make sense and I would update the patchset.
> > 
> > 
> > The only other concern is, would this extra warning causing more hassles 
> > for Josef to sync the kernel and progs code?
> 
> I don't know yet but it is possible that it would.  In that case the separate
> patch would make it easier to enable once all warnings are fixed, I can keep it
> at the top of the branch.

Do you want me to run these warnings through my series and re-send?  That may be
faster than trying to merge everything together.  Thanks,

Josef
