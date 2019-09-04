Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39CD8A7D42
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 10:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfIDIDS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 04:03:18 -0400
Received: from mail5.windriver.com ([192.103.53.11]:44648 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfIDIDQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Sep 2019 04:03:16 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x8482cDn016609
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 4 Sep 2019 01:02:49 -0700
Received: from [128.224.162.188] (128.224.162.188) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 4 Sep
 2019 01:02:27 -0700
From:   "Hongzhi, Song" <hongzhi.song@windriver.com>
Subject: Bug?: unlink cause btrfs error but other fs don't
To:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <josef@toxicpanda.com>
Message-ID: <49edadc4-9191-da89-3e3b-ca495f582a4d@windriver.com>
Date:   Wed, 4 Sep 2019 16:02:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------935A56B25A949F598160A930"
Content-Language: en-US
X-Originating-IP: [128.224.162.188]
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--------------935A56B25A949F598160A930
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi ,


*Kernel:*

     After v5.2-rc1, qemux86-64

     make -j40 ARCH=x86_64 CROSS_COMPILE=x86-64-gcc
     use qemu to bootup kernel


*Reproduce:*

     There is a test case failed on btrfs but success on other 
fs(ext4,ext3), see attachment.


     Download attachments:

         gcc test.c -o myout -Wall -lpthread

         copy myout and run.sh to your qemu same directory.

         on qemu:

             ./run.sh


     I found the block device size with btrfs set 512M will cause the error.
     256M and 1G all success.


*Error info:*

     "BTRFS warning (device loop0): could not allocate space for a 
delete; will truncate on mount"


*Related patch:*

     I use git bisect to find the following patch introduces the issue.

     commit c8eaeac7b734347c3afba7008b7af62f37b9c140
     Author: Josef Bacik <josef@toxicpanda.com>
     Date:   Wed Apr 10 15:56:10 2019 -0400

         btrfs: reserve delalloc metadata differently
         ...


Anyone's reply will be appreciated.

--Hongzhi


--------------935A56B25A949F598160A930
Content-Type: application/x-shellscript; name="run.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="run.sh"

IyBjaGVjayBwZXJtaXNzaW9uCkNVUl9VU0VSPWBlbnYgfCBncmVwIFVTRVI9IHwgY3V0IC1k
ICI9IiAtZiAyYApmb3IgaSBpbiAkQ1VSX1VTRVIKZG8KICAgIGlmIFsgJGkgPSAicm9vdCIg
XTt0aGVuCiAgICAgICAgYnJlYWsKICAgIGVsc2UKICAgICAgICBlY2hvICJyZXF1aXJlIHJv
b3QgcGVybWlzc2lvbihyb290L3N1ZG8pIgogICAgICAgIGV4aXQKICAgIGZpCmRvbmUKCiMg
Y3JlYXRlIGJ0cmZzIGJsb2NrIGRldmljZSBhbmQgbW91bnQKQkxPQ0tfU0laRT1gZXhwciA1
MTIgXCogMTAyNGAKCmRkIGlmPS9kZXYvemVybyBvZj0kSE9NRS90ZXN0LmltZyBicz0xMDI0
IGNvdW50PSRCTE9DS19TSVpFCm1rZnMuYnRyZnMgLWYgJEhPTUUvdGVzdC5pbWcKCmlmIFsg
ISAtZCAiJEhPTUUvdG1wbW50IiBdOyB0aGVuCglta2RpciAkSE9NRS90bXBtbnQKZWxzZQoJ
cm0gLXJmICRIT01FL3RtcG1udAoJbWtkaXIgJEhPTUUvdG1wbW50CmZpCgptb3VudCAkSE9N
RS90ZXN0LmltZyAkSE9NRS90bXBtbnQKCiMgaW1wbGVtZW50IHRlc3QgY2FzZQouL215b3V0
Cgp1bW91bnQgJEhPTUUvdG1wbW50CnJtIC1yZiAkSE9NRS90bXBtbnQKcm0gLXJmICRIT01F
L3Rlc3QuaW1nCg==
--------------935A56B25A949F598160A930
Content-Type: text/x-csrc; name="test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="test.c"

/**
 * mount a 512M btrfs block device.
 * and then fill the block device to the full with multi threads(ncpus+2).
 * and then unlink the files in the block device with multi threads.
 * 
 */


#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <sys/stat.h>
#include <sys/vfs.h>
#include <fcntl.h>
#include <libgen.h>
#include <signal.h>
#include <stdarg.h>
#include <unistd.h>
#include <dirent.h>
#include <grp.h>
#include <sys/ioctl.h>     
#include <dirent.h>
#include <stdio.h>
#include <errno.h>
#include <pthread.h>
#include <string.h>

//#define PATH_MAX 512

unsigned int nthreads;
static volatile int run;
struct worker *workers;
static int enospc_cnt;	//no space count
const char *homepath;

struct worker {
    char dir[PATH_MAX];
};

#define MIN(a, b) ({\
    typeof(a) _a = (a); \
    typeof(b) _b = (b); \
    _a < _b ? _a : _b; \
})

#define pr_err(a) do{\
    printf("%s:%d:\n", __FILE__, __LINE__); \
    perror(a); \
}while(0)

unsigned int get_ncpus_conf()
{
	unsigned int ncpus_conf = -1;

	if ( (ncpus_conf = sysconf(_SC_NPROCESSORS_CONF)) == -1 ) {
		pr_err("Fail to get ncpus!");
		exit(1);
	}

	return ncpus_conf;
}

void fill_fs(const char *path)
{
    int i = 0;
    char file[PATH_MAX];
    char buf[4096];
    size_t len;
    ssize_t ret;
    int fd;

    for (;;) {
        len = random() % (1024 * 102400);

        snprintf(file, sizeof(file), "%s/file%i", path, i++);
        printf("%s \n", file);

        fd = open(file, O_WRONLY | O_CREAT, 0700);
        if (fd == -1) {
            if (errno != ENOSPC)
                pr_err("Fail to open()");
				exit(1);

            printf("No space to open() \n");
            return;
        }

        while (len) {
            ret = write(fd, buf, MIN(len, sizeof(buf)));

            if (ret < 0) {
                close(fd);

                if (errno != ENOSPC)
                    pr_err("Fail to write()");

                printf("No space to write() \n");
                return;
            }

            len -= ret;
        }

        close(fd);
    }
}

static void *worker(void *p)
{

    struct worker *w = p;
    DIR *d;
    struct dirent *ent;
    char file[2*PATH_MAX];

    while (run) {
        fill_fs(w->dir);

         __atomic_fetch_add(&enospc_cnt, 1, __ATOMIC_SEQ_CST);

        d = opendir(w->dir);
        while ((ent = readdir(d))) {

            if (!strcmp(ent->d_name, ".") || !strcmp(ent->d_name, ".."))
                continue;

            snprintf(file, sizeof(file), "%s/%s", w->dir, ent->d_name);

            printf("Unlinking %s \n", file);

            if( unlink(file) ) {
				pr_err("Fail to unlink");
			}
            break;
        }
        closedir(d);
    }

    return NULL;
}


int main()
{
	unsigned int i, ms;

    homepath = getenv("HOME");

	nthreads = get_ncpus_conf() + 2;
    pthread_t threads[nthreads];

	workers = malloc(sizeof(struct worker) * nthreads);
	if (!workers) {
		pr_err("Fail to malloc workers!");
		exit(1);
	}

	for (i = 0; i < nthreads; i++) {
        snprintf(workers[i].dir, sizeof(workers[i].dir), \
        "%s/tmpmnt/thread%i", homepath, i + 1);

        if( mkdir(workers[i].dir, 0700) ){
			pr_err("Fail to mkdir workerdir");
			exit(1);
		}
    }

	printf("Running %d writer threads \n", nthreads);

	run = 1;
    for (i = 0; i < nthreads; i++) {
        if( pthread_create(&threads[i], NULL, worker, &workers[i]) ) {
			pr_err("Fail to create pthread");
			exit(1);
		}
    }

    for (ms = 0; ; ms++) {
        usleep(1000);

        if (ms >= 1000 && enospc_cnt)
            break;

        if (enospc_cnt > 100)
            break;
    }

    run = 0;
    for (i = 0; i < nthreads; i++){
        if( pthread_join(threads[i], NULL) ) {
			pr_err("Fail to pthread_join");
		}
    }

    printf("Got %d ENOSPC runtime %dms \n", enospc_cnt, ms);
	
	return 0;
}

--------------935A56B25A949F598160A930--
