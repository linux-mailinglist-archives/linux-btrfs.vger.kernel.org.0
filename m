Return-Path: <linux-btrfs+bounces-16694-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EBBB48159
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 01:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D4EC7A8582
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Sep 2025 23:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110531EE7B9;
	Sun,  7 Sep 2025 23:32:48 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC42182B7;
	Sun,  7 Sep 2025 23:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757287967; cv=none; b=Xh3T0/Xk9dQUPA6/mRvIfkC7bOrBagE7N582elj6esg40KCcWLufn0IsYi8rYIjBF4hSx7lpAyiWwevgwJcm1Bzl8o9nMUKFsCGCcDs7icg+oD8JNTIxJsnY6r8m1Y9xnr+cE+XsHK0qNOyj3VQLbi8VRkm9ICeW2qlWl8paT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757287967; c=relaxed/simple;
	bh=8Q51Pi1YMf2o7qtRi+WMwzn7RU9lfIFXDb2l23Cg46M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIAOCCXEETCTbaNXUXPNFWLSgdqDV17ioOlwDSf+SR9+Kk5W/twmnSuI4qSnUWnKTh/wFDs6jFiEB83XH7ykLz7b93aYx66qj4yucPCLTq5cJMtoa3s7o4P120FI/3ZLOXUbW1iVux5aq9wBAdI5H8Ak9VGUHIXdEkfCisplejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-621b8b0893bso3816845a12.2;
        Sun, 07 Sep 2025 16:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757287964; x=1757892764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSOYWEdNdMsjQK2SDIrPCn0RXg6huyCIb9JmTGv+MCE=;
        b=PH1W65UogFyFc4jDJrhISrclOVT88ZQltcfbpR3yrggwDKWNXDx7C9/ywYRSV5p/ef
         oY2ZexnfakyKIoG/iKlyErJ0sB3JUA6Djo8oKOgJ2gcJJ2EZZh2+qnz4+hUkqm1Iptxd
         Jv6vh3LiubVmlHuo8lqzaFK4lsxklBoWyFmdstLbDxBdq1R6N9BqSTDVEBOOmA6KiMCj
         +0w0NPdwoI885MQCfPn+plE0qEA9ftBdKSqPr74Fk7YXqKqNMXYPuAeHDWQDWgcHyw+Q
         IjhS/+jiG0Bl+yqS9N07sre/gvpQkkWdQEkK57jG180PyGYqRY7ByOc06e+TJaKArOgL
         0rQw==
X-Forwarded-Encrypted: i=1; AJvYcCUxN8lcS6xsOyhw9itj7T83LFzfK7RtSC4/Vrn+BJOUs2SufI2ssIDSHbIaTpC9MEz2jAIZQdeY@vger.kernel.org
X-Gm-Message-State: AOJu0YwELYvhwDo4zCilA99BYaiIE+xd1sXdI7qJbkWy4mE4w4S38a3W
	ozUnsXOwrWzrC+hAQ2T2Xnvwc4Yy2cqkIVAv/0bAMp5QumE5P2lSCjrgKnfylfj303g=
X-Gm-Gg: ASbGncsMrQuG6BMvx4ma/Fo6pwOYSzuL3ZXX9h070CpRcAv50sVEkrieesDadIcELTY
	aR34kYIAi2x5yoYlHS0H33+ldCvOxdhlnX2TLoAZLvDUVGlm0MqTbulrwhPFllWJK6NypU3GY5d
	au9zsMHVio2Dkqh55T4QfCDu9c4y4kOe+irOs/EV9NT/X5QQHs4rrkbuFAglsT2aI86Guj8WH4E
	PwYnQ1FFJdCi9ZO3vtgR+cTkVLomEwAokm6QWR1yNA04K8ZHvPFVKQ1W9D6wUB3aeFDfvPW5RA0
	UPfEzIg/A7U2qNoglzeyzL9kSeTx8f6bmUOqqd4FB+UWWoGhdGeVWU/FDKdQkK/tXrE6M0e//DN
	sSk0/aOSjZiqaKmX2j6hxLkYHo88AExaa2sWQFF3IMfThbWyN5FwkiG9UtWzktZjDisNTzqnGNG
	nc40kPYxdH
X-Google-Smtp-Source: AGHT+IGkya/ek/Udb2RxDT7P4x12XsG4rCCyRmRtiHBSm9fUBy7Aaibp65MZglWMFKYgeRENBu2yow==
X-Received: by 2002:a05:6402:5110:b0:627:5841:7ae1 with SMTP id 4fb4d7f45d1cf-62758417d89mr3175791a12.21.1757287963654;
        Sun, 07 Sep 2025 16:32:43 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62637893a93sm3221654a12.46.2025.09.07.16.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 16:32:43 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso216935a12.3;
        Sun, 07 Sep 2025 16:32:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdM+gje/6KaQbzLaZehDxrT1hDJ2Dl+6p/SGK46VltKShgUYY8Nrn3T7Srqpw6oVycM6s/ogw5@vger.kernel.org
X-Received: by 2002:a17:907:94d1:b0:afe:8a40:49bb with SMTP id
 a640c23a62f3a-b04b140a542mr563049866b.22.1757287963141; Sun, 07 Sep 2025
 16:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904214415.10628-1-wqu@suse.com>
In-Reply-To: <20250904214415.10628-1-wqu@suse.com>
From: Neal Gompa <neal@gompa.dev>
Date: Mon, 8 Sep 2025 01:32:06 +0200
X-Gmail-Original-Message-ID: <CAEg-Je96ywspV9v9UiiHCq6w=oiVKUGnwUq+dgnXbLcZOW=LsQ@mail.gmail.com>
X-Gm-Features: Ac12FXzkGdKELup4O7vqS44YdwcElFmts4ygjkASQlrXdnWB50BiNxx-a2jwZhg
Message-ID: <CAEg-Je96ywspV9v9UiiHCq6w=oiVKUGnwUq+dgnXbLcZOW=LsQ@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: generic/733: avoid output difference due to
 bash's version
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:44=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [FALSE ALERT]
> When running generic/733 with bash 5.3.3 (any thing newer than 5.3.0
> will reproduce the bug), the test case will fail like the following:
>
> generic/733 19s ... - output mismatch (see /home/adam/xfstests/results//g=
eneric/733.out.bad)
>     --- tests/generic/733.out   2025-09-04 17:30:08.568000000 +0930
>     +++ /home/adam/xfstests/results//generic/733.out.bad        2025-09-0=
4 17:30:32.898475103 +0930
>     @@ -2,5 +2,5 @@
>      Format and mount
>      Create a many-block file
>      Reflink the big file
>     -Terminated
>     +Terminated                 $here/src/t_reflink_read_race "$testdir/f=
ile1" "$testdir/file2" "$testdir/outcome" &>> $seqres.full
>      test completed successfully
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/generic/733.out /home/adam/xf=
stests/results//generic/733.out.bad'  to see the entire diff)
>
> [CAUSE]
> The failure is fs independent, but bash version dependent.
>
> In bash v5.3.x, the job control will output the command which triggered
> the job control (from termination to core dump etc).
>
> The "Terminated" message is not from the program, but from bash's job
> control, thus redirection won't hide that message.
>
> [FIX]
> Run the command in a command group, which will be executed in a
> subshell.
>
> By this we can redirect the output of the subshell, including the job
> control message, thus hide the different output pattern caused by
> different bash versions.
>
> Thankfully this particular test case does extra checks on the outcome
> file to determine if the program is properly terminated, thus we are
> safe to move the "Terminated" line from the golden output to
> seqres.full.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> v2:
> - Use command grouping instead of background execution
>   Background execution requires extra cleanup to wait for the background
>   program.
>   Meanwhile command grouping will run in a subshell thus we can redirect
>   everything including the job control message.
>
>   Thanks Darrick for pointing this solution out.
> ---
>  tests/generic/733     | 17 +++++++++++++++--
>  tests/generic/733.out |  1 -
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/tests/generic/733 b/tests/generic/733
> index aa7ad994..21347d51 100755
> --- a/tests/generic/733
> +++ b/tests/generic/733
> @@ -70,8 +70,21 @@ done
>  echo "fnr=3D$fnr" >> $seqres.full
>
>  echo "Reflink the big file"
> -$here/src/t_reflink_read_race "$testdir/file1" "$testdir/file2" \
> -       "$testdir/outcome" &>> $seqres.full
> +# Workaround the default job control by command grouping so that we can =
redirect
> +# the job control message of the subshell.
> +#
> +# Job control of bash v5.3.x will output the command which triggered the=
 job
> +# control (terminated, core dump etc).
> +# And since it's handled by bash itself, redirection of the program won'=
t work
> +# for the job control message.
> +#
> +# Running the command in a command group will make the program run in a =
subshell
> +# so that we can direct the job control message of the subshell.
> +#
> +# We will check the outcome file to determine if the program is properly
> +# terminated, thus no need to bother the job control message.
> +{ $here/src/t_reflink_read_race "$testdir/file1" "$testdir/file2" \
> +       "$testdir/outcome" ; } &>> $seqres.full
>
>  if [ ! -e "$testdir/outcome" ]; then
>         echo "Could not set up program"
> diff --git a/tests/generic/733.out b/tests/generic/733.out
> index d4f5a7c7..2383cc8d 100644
> --- a/tests/generic/733.out
> +++ b/tests/generic/733.out
> @@ -2,5 +2,4 @@ QA output created by 733
>  Format and mount
>  Create a many-block file
>  Reflink the big file
> -Terminated
>  test completed successfully
> --
> 2.51.0
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

