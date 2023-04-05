Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF446D7EF4
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 16:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238213AbjDEOPg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 10:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbjDEOPe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 10:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372706196
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680703966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=net1/YQpLyeedtAUAtKmhMoSFz+7An5MzKe0V2cpLas=;
        b=hKDn+8G6Hfc2xxhAtQr0rBAVgkX93WWD+hGGK01Z7AFpuRTpsb/yoIb0P3eLHehD5F5NHA
        uNXokUGa6GASQj1eCr7lUFxTc2laRRRwApnz2xy8/9YOCVndkuiD8iY7QdaJ7lL3hTsLHX
        iJK40CE1J1pfi4kZ2TUb5RXDoV7IxXQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-JRyWeOmONBqjeh1Os3_FaA-1; Wed, 05 Apr 2023 10:02:12 -0400
X-MC-Unique: JRyWeOmONBqjeh1Os3_FaA-1
Received: by mail-pj1-f69.google.com with SMTP id b16-20020a17090a991000b0023f803081beso11463495pjp.3
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Apr 2023 07:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680703331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=net1/YQpLyeedtAUAtKmhMoSFz+7An5MzKe0V2cpLas=;
        b=5HdhooqlNL87XMaRla5wKVjGLX8XSx/fSScKma9GgDj4GgDDIEhf75S/x0eamkOo7K
         gSWPTPeFEEreYI/PknoOHgJWbWFL2UOteI029VTiGld+VyS/JkqC6TZkV465llb2f4DQ
         L5DSk2ICoRm8IbIIwLbJrgMZP/Jt4iKtpo210UTY1OQbyXJkp5U0u/vn4qSz/8W6Vi+7
         V0il+Pg73eAdahyhZdRpCnpa5Aqriwxak4eapMvTISFru3QIDsw2PL9PqBH/VAQ6Maso
         RAjrAPi7nCRLK4oWESIU3FUBc2i3mjree9CH+6n+qlthkjZ2hlO4GSAuh/MA7z9pJQR6
         FXeg==
X-Gm-Message-State: AAQBX9f+hcZrbAQUQYKmP4S/LiN3g+3LFeZdFDvVMyMgmT3v9TTFphCe
        8Ty582hdztAp3W+sztjUiq1Vkk1FWSnbu7RlKRHsMQOw+pJg81T5SwA3NKINKIyeXe5AeAetcmZ
        2rNaqdTgPucvMr4hSkwJm+ZU=
X-Received: by 2002:a17:903:283:b0:1a1:cd69:d301 with SMTP id j3-20020a170903028300b001a1cd69d301mr6292233plr.68.1680703330930;
        Wed, 05 Apr 2023 07:02:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z3hrO2tDczikPPadND/siCWP3StMDF6ZwRfuQDU1LtW+SuQXatmasFWBRAsAV4qHbVdUEpFA==
X-Received: by 2002:a17:903:283:b0:1a1:cd69:d301 with SMTP id j3-20020a170903028300b001a1cd69d301mr6292202plr.68.1680703330583;
        Wed, 05 Apr 2023 07:02:10 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b24-20020a630c18000000b005023496e339sm9037285pgl.63.2023.04.05.07.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:02:10 -0700 (PDT)
Date:   Wed, 5 Apr 2023 22:02:02 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
        brauner@kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, djwong@kernel.org, amir73il@gmail.com,
        linux-unionfs@vger.kernel.org, anand.jain@oracle.com,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        fdmanana@suse.com, jack@suse.com, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/5] fstests/MAINTAINERS: add supported mailing list
Message-ID: <20230405140202.bdp3lzgross2cjbt@zlang-mailbox>
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-4-zlang@kernel.org>
 <20230404221653.GC1893@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404221653.GC1893@sol.localdomain>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 04, 2023 at 03:16:53PM -0700, Eric Biggers wrote:
> Hi Zorro,
> 
> On Wed, Apr 05, 2023 at 01:14:09AM +0800, Zorro Lang wrote:
> > +FSVERITY
> > +L:	fsverity@lists.linux.dev
> > +S:	Supported
> > +F:	common/verity
> > +
> > +FSCRYPT
> > +L:      linux-fscrypt@vger.kernel.org
> > +S:	Supported
> > +F:	common/encrypt
> 
> Most of the encrypt and verity tests are in tests/generic/ and are in the
> 'encrypt' or 'verity' test groups.
> 
> These file patterns only pick up the common files, not the actual tests.
> 
> Have you considered adding a way to specify maintainers for a test group?
> Something like:
> 
>     G:      encrypt
> 
> and
> 
>     G:      verity

Good idea! Let's check if this patchset is acceptable by most of you,
then I'll think about how to add this feature later.

Thanks,
Zorro

> 
> - Eric
> 

