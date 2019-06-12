Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFA341ADC
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 05:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406893AbfFLD42 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jun 2019 23:56:28 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:39050 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406758AbfFLD42 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jun 2019 23:56:28 -0400
Received: by mail-ot1-f52.google.com with SMTP id r21so14099615otq.6
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2019 20:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=vmGoNcyD5GGAmW46IoeXAbFfkXaEcsrpNj9AWBpzcXY=;
        b=bon2lUPltesTtgu9SznlMBmsZMfpuNuGuLQp0a2qv6orGd+qCsBNp8XzopJ/QKc6L2
         zlMcJfhXy1sBNs+dOm52hnTa9SA4fwcBCo1eW3czOmGabmYczu434Rxg+o9eHPcIeOCd
         ldf0IREAVO2ZfY8zcJO5qQyXk6Uz1u7cGZLDlec6v5IrkbI6SyyUchFvNXMNiR1Qvjiv
         006yKk8191F7AGkxZ/NNth7hPklpCK0/hZ3CV/nasjkkRcqcj83BNHiDUXNAM1Tfo6ER
         qg4r7pEnEuVsnWi+ptl8i5hf2Hl8lY8TolZ2fFRKO8zcvmllh/6v6AhNFm4odJsVUhsI
         EO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vmGoNcyD5GGAmW46IoeXAbFfkXaEcsrpNj9AWBpzcXY=;
        b=A0BT3GEOsUFdrxmxii8kpOa7uk4k8oNL0x4Q8IzEV7IYvv8wWzGv2tIqLSAzmuPmHL
         YsZ8w6RMivdf6teCd6cAPQOLO4nOGikrsHOIo+55iH70T0Va92TwaJ3MMoLRsgGfQw6Z
         pT9oJ9c5h2KHmSzI0LHvNeDjfo/q+ykxzQqkaKLInEdFxIhIsDPZWgxdJVd6j16qiJzk
         nNQ/B1jY91zlAMQrlpQNm+5jI5rlgSxJmTodQKd+gDdBnw+DK93Cdo6LvXYxMtqvmmku
         Oy8wJ58EzH6hU+4pt/Kazp+u6UmSCVIiJGMXE8RcupL3YXKiK7uk6d+JwBFoPHelUBrW
         AhSQ==
X-Gm-Message-State: APjAAAVG38Jhwtx9hrHoAwVY4wg0jbEYeiqxJQiMVNZf6o5WUgJ7qZhT
        i28v6RQ1qTYceRSLJW67IThyfw/ESb+ikVgsBKlmQgN22uM=
X-Google-Smtp-Source: APXvYqy85cdC1LbMp+qLi2aF+Oq9wlAbLVz2lf/O0eLtOs/eMYO184/fD2plwaNfVjI7/0JEa/pJx/4Qllvg7hNqLgQ=
X-Received: by 2002:a9d:a76:: with SMTP id 109mr10762630otg.252.1560311787236;
 Tue, 11 Jun 2019 20:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <CACVqEWkAQzFF3MuA4ghBUjvEBdQNSuuPH7geMntQOeKdVYwoiQ@mail.gmail.com>
In-Reply-To: <CACVqEWkAQzFF3MuA4ghBUjvEBdQNSuuPH7geMntQOeKdVYwoiQ@mail.gmail.com>
From:   Michael Adams <unquietwiki@gmail.com>
Date:   Tue, 11 Jun 2019 20:56:14 -0700
Message-ID: <CACVqEWkO5ZKMMh=mgBNyF-Ou78JRCVbxRh_fmaB9WBw7xy6Pvw@mail.gmail.com>
Subject: Re: Attempt to fix Github Issue #59 for btrfs-progs (looping issue)
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I integrated the #59 fix with two other fixes: one from a different author.

https://github.com/kdave/btrfs-progs/pull/181

On Mon, Jun 3, 2019 at 4:25 PM Michael Adams <unquietwiki@gmail.com> wrote:
>
> I'm in the middle of a projected 92TB btrfs restore to another server
> and kept having issues keeping the restore going past the first 200GB.
> I created an "Ignore" option for the loop question, mentioned in issue
> #59; and it's managed to restore several terabytes so far.
>
> https://github.com/kdave/btrfs-progs/issues/59#issuecomment-497917965
>
> https://github.com/unquietwiki/btrfs-progs/commit/6f4959237077b8fc95339167ecdd07241c8db937
>
> --
>
> Michael Adams
> https://unquietwiki.com/



-- 

Michael Adams
https://unquietwiki.com/
