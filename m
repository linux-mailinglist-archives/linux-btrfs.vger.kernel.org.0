Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF514240AEC
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 18:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgHJQCk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 12:02:40 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:62944 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgHJQCj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 12:02:39 -0400
Received: from mail.tol.fr (unknown [IPv6:2a01:e34:eeaf:c5f0:21e:62ff:fe00:36])
        by smtp5-g21.free.fr (Postfix) with ESMTPS id 2F7875FFB1;
        Mon, 10 Aug 2020 18:02:06 +0200 (CEST)
Subject: Re: Is there some doc or some example of libbtrfs ?
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=couderc.eu; s=2017;
        t=1597075325; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYEf3skRz48RdfjQfrfKQnCwtnpMiPNuih8m3xwjgm4=;
        b=QHBKg7yKc2Fj2yRIrVSvCHdboWfoSLs3cwZ+/iTfXRGIRNEZlK6vmbX089O6DFb2V1JLJt
        AHs7Ia1nZC+K26qCK/fDRY+sMMbK/XBTfVsizzkzXY8uaHx5J2osPGSQfuaahVCMiMbZ1s
        ESBCI2s3BAvc4gtUf6u737d/Y3DA9piUYvBp5/qLApq22cxizWA0UV1ZXysG5VX84qc+fY
        Vw4F+dFdxcIc6M3fPI7hefOifTLsp6k3t9ywvZt2VNgQRrXM0dPIwzKeL+ruOxt0RYDLlN
        MqzJyFmH/4ZITiaKTq64xW3hEeGH33qIkFQRunz5pmFjhxSvmDaKRrjkPzIDpA==
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <4bf44e81-0b4f-9c99-3010-410e110aec2d@couderc.eu>
 <20200810151327.GC2026@twin.jikos.cz>
From:   Pierre Couderc <pierre@couderc.eu>
Message-ID: <dc5641a3-1baa-6676-fa88-6176a3c5cadf@couderc.eu>
Date:   Mon, 10 Aug 2020 18:02:04 +0200
MIME-Version: 1.0
In-Reply-To: <20200810151327.GC2026@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=couderc.eu;
        s=2017; t=1597075325; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYEf3skRz48RdfjQfrfKQnCwtnpMiPNuih8m3xwjgm4=;
        b=JGUI2VNc9gBauxSNM9Paw/QdiJRBlzPfStPEVKlBLUE4EWbPEIGIU/BfDiNbib4Na9sAIW
        P+x1gsrP1e05byL3bvayMS2tPC52Tgg/KneEwS2dsgfQGAE0Wpy62aW9ZYiM5jTYEYlcI5
        75zbcfjSA0L+9gFaEkBSHBEqh3BSSyeboq8wVYzuFnjv7XHdvV2qBjK3etKmYHJy563816
        BoIQ4hJG+4V1bJZ3GoRiHqwKFIOmpoVvO/fj3rf0lHWbHALV8y1FT/ChBMntG5BZAb4Scg
        vNMt7LN3tAj1PZwex/aMXbw8+jt6T7llhY8jXA5Jhwb7rCQIQFhgQfD4auqNlA==
ARC-Seal: i=1; s=2017; d=couderc.eu; t=1597075325; a=rsa-sha256; cv=none;
        b=LkUlu4p1Gl6VlVEDw9H5czAEX7Az2j5d4X0QuynAlTLCu+1WcYl1InLF302KRbtIkTbIewQRkQKeFKMIvUtU1rX/IdLjQtOMbQ/E471Vs1Z8Qp/UB0Ge0ApJLka8iQGnoHthGM5y9jmWF1bsXl3sXww2rRa/76xCLxn3silzuY7Nn6jCddlOknkvnDocuj0ydEERSqnm2lOTXKy8DGqXq4Kgf7Oi0N/mBrAY+c6rIgqSX4UghoWuj0gocoZk5bugMXsECzQPqGuA0fBArX0KzQ8JhWLkktfl9a4hJaFqXPmYQ6B1q2WxvgD4FPH3A5/tQZYEg2FQ4DjrJJVNjTA4aQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=tol smtp.mailfrom=pierre@couderc.eu
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/10/20 5:13 PM, David Sterba wrote:
> On Fri, Aug 07, 2020 at 11:36:10AM +0200, Pierre Couderc wrote:
>> Ho do I get programmatically the list of the snapshots of a volume in C/C++?
>>
>> I can analyse the output of "btrfs li sh", but is there an easier way ?
>>
>> I have found no doc or example...
> Please don't use libbtrfs, that's going to be removed in the future.
> There's a proper library libbtrfsutil. See
> btrfs_util_create_subvolume_iterator.

ok I note that. Thnak you.


